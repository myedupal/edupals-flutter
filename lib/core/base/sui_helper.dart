import 'dart:convert';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/user_key.dart';
import 'package:flutter/foundation.dart';
import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/utils/hex.dart';
import 'package:zklogin/address.dart';
import 'package:zklogin/nonce.dart';

extension SuiHelper on MainController {
  void getUserKeyData() async {
    final UserKey? userKeyData = await localRepo.getUserKeyData();
    if (userKeyData != null) {
      userKey = userKeyData;
      suiAccount = SuiAccount.fromPrivKey(
        userKeyData.privateKey ?? "",
      );
    } else {
      prepareLogin();
    }
  }

  void onSetSuiAddress() {
    Uint8List bytes = base64.decode(userSalt ?? "");

    suiAddress = jwtToAddress(
      jwt ?? "",
      toBigIntBE(bytes),
    );
  }

  BigInt toBigIntBE(Uint8List bytes) {
    String hex = Hex.encode(bytes);
    if (hex.isEmpty) {
      return BigInt.from(0);
    }
    return BigInt.parse('0x$hex');
  }

  void prepareLogin() async {
    // Create Ephemeral Account
    suiAccount = SuiAccount(Ed25519Keypair());
    final result = await suiClient.getLatestSuiSystemState();
    // Create Sui max epoch
    userKey?.maxEpoch = int.parse(result.epoch) + 10;
    userKey?.publicKey = suiAccount?.keyPair.getPublicKey().toBase64();
    userKey?.privateKey = suiAccount?.privateKey();
    // Create randomness
    userKey?.randomness = generateRandomness();
    // Create nonce
    userKey?.nonce = generateNonce(suiAccount!.keyPair.getPublicKey(),
        userKey?.maxEpoch ?? 0, userKey?.randomness ?? "");
    debugPrint("My user key ${userKey?.privateKey}");
    await localRepo.setUserKeyData(jsonEncode(userKey));
  }
}
