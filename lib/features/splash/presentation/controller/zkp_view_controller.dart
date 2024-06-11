import 'dart:convert';
import 'dart:typed_data';

import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/user_key.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/features/splash/domain/model/zk_proof.dart';
import 'package:edupals/features/splash/domain/repository/sui_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sui/sui.dart';
import 'package:zklogin/address.dart';
import 'package:zklogin/nonce.dart';
import 'package:zklogin/utils.dart';

class ZkpViewController extends GetxController {
  final SuiRepository suiRepo = Get.find();
  final MainController mainController = Get.find();
  final LocalRepository localRepo = Get.find();
  ZkLoginSignatureInputs? zkProof;

  @override
  void onInit() {
    super.onInit();
  }

  void getZkProof() async {
    final UserKey? userKey = mainController.userKey;
    final String? jwt = mainController.jwt;
    final Uint8List salt = base64.decode(mainController.userSalt ?? "");
    await suiRepo.getZkProof(
        requestBody: ZkProofRequest(
          jwt: jwt,
          extendedEphemeralPublicKey: userKey?.publicKey ?? "",
          maxEpoch: "${userKey?.maxEpoch}",
          jwtRandomness: userKey?.randomness,
          salt: "${toBigIntBE(salt)}",
          keyClaimName: "sub",
        ),
        onSuccess: (value) {
          zkProof = value;
          triggerTransaction();
        },
        onError: (error) {});
  }

  // Define PTB (Frontend trigger sui chain action)
  void triggerTransaction() async {
    final BigInt salt =
        toBigIntBE(base64.decode(mainController.userSalt ?? ""));
    final String address = mainController.suiAddress ?? "";
    final String? jwt = mainController.jwt;
    final SuiClient suiClient = mainController.suiClient;
    final SuiAccount? account = mainController.suiAccount;
    final UserKey? userKey = mainController.userKey;

    final txb = TransactionBlock();
    txb.setSenderIfNotSet(address);
    final coin = txb.splitCoins(txb.gas, [txb.pureInt(222)]);
    txb.transferObjects([coin], txb.pureAddress(address));
    final sign = await txb.sign(
      SignOptions(
        signer: account!.keyPair,
        client: suiClient,
      ),
    );
    final jwtJson = decodeJwt(jwt ?? "");
    final addressSeed = genAddressSeed(
      salt,
      'sub',
      jwtJson['sub'].toString(),
      jwtJson['aud'].toString(),
    );
    zkProof?.addressSeed = addressSeed.toString();
    final zkSign = getZkLoginSignature(
      ZkLoginSignature(
        inputs: zkProof!,
        maxEpoch: userKey?.maxEpoch ?? 0,
        userSignature: base64Decode(sign.signature),
      ),
    );
    final resp = await suiClient.executeTransactionBlock(
      sign.bytes,
      [zkSign],
      options: SuiTransactionBlockResponseOptions(showEffects: true),
      requestType: ExecuteTransaction.WaitForLocalExecution,
    );
    debugPrint("Transaction response ${resp.confirmedLocalExecution}");
  }
}
