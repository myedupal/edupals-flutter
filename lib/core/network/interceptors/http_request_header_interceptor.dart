import 'dart:io';

import 'package:edupals/core/base/base_snackbar.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HttpRequestHeaderInterceptor extends Interceptor {
  final LocalRepository _localRepository = Get.find();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Map<String, dynamic> extra = options.extra;
    final bool requiresToken = extra['authorization'] ?? false;
    final String? accessToken = await _localRepository.getAccessToken();

    options.headers[HttpHeaders.contentTypeHeader] =
        ApiConstants.contentTypeJson;
    options.headers['X-Channel'] = 'MA';
    if (requiresToken) {
      options.headers[HttpHeaders.authorizationHeader] = '$accessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final LocalRepository localRepository = Get.find();
    final MainController mainController = Get.find();

    if (err.type == DioExceptionType.badResponse && err.response != null) {
      // force logout
      if (err.response?.statusCode == 401) {
        if (Get.currentRoute != Routes.login) {
          await localRepository.clearStorage();
          await mainController.logout();
          BaseSnackBar.show(message: "Please login again.");
        }
      }
    }
    super.onError(err, handler);
  }
}
