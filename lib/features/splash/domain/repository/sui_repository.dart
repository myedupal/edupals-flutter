import 'dart:convert';

import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/splash/domain/model/zk_proof.dart';
import 'package:get/get.dart';
import 'package:sui/sui.dart';

class SuiRepository {
  final DioClient dioClient = Get.find();

  Future<void> getZkProof(
      {required ZkProofRequest requestBody,
      required Function(ZkLoginSignatureInputs?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(ApiConstants.getZkProof,
            authorization: true, body: jsonEncode(requestBody))
        .handleResponse(
          onSuccess: (value) => {
            value.data["addressSeed"] = "",
            onSuccess.call(ZkLoginSignatureInputs.fromJson(value.data))
          },
          onError: onError,
        );
  }
}
