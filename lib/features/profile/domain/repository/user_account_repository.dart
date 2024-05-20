import 'dart:convert';

import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:get/get.dart';

class UserAccountRepository {
  final DioClient dioClient = Get.find();

  Future<void> getAccount(
      {required Function(User?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getUserAccount,
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(UserWrapper.fromJson(value.data).user),
          onError: onError,
        );
  }

  Future<void> updateAccount(
      {required User user,
      required Function(User?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .put(
          ApiConstants.getUserAccount,
          body: jsonEncode(UserWrapper(account: user)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(UserWrapper.fromJson(value.data).user),
          onError: onError,
        );
  }

  Future<void> updatePassword(
      {required User user,
      required Function(User?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .put(
          "${ApiConstants.getUserAccount}/password",
          body: jsonEncode(UserWrapper(account: user)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(UserWrapper.fromJson(value.data).user),
          onError: onError,
        );
  }
}
