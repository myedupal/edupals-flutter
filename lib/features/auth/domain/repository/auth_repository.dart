import 'dart:convert';

import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:get/get.dart';

class AuthRepository {
  final DioClient dioClient = Get.find();

  Future<void> login(
      {required User user,
      required Function(User?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.getLogin,
          body: jsonEncode(UserWrapper(user: user)),
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(User.fromJson(value.data)),
          onError: onError,
        );
  }

  Future<void> register(
      {required User user,
      required Function(User?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.getUser,
          body: jsonEncode(UserWrapper(user: user)),
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(User.fromJson(value.data)),
          onError: onError,
        );
  }

  Future<void> logout(
      {required Function(bool?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .delete(
          ApiConstants.getLogout,
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(true),
          onError: onError,
        );
  }
}
