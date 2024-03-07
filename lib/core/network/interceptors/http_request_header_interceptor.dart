import 'dart:io';

import 'package:edupals/core/repositories/local_repository.dart';
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

    final Map<String, dynamic> extra = err.requestOptions.extra;

    final String url = extra['fullUrl'] ?? "";

    if (err.type == DioExceptionType.badResponse && err.response != null) {
      String? statusCode;

      if (err.response != null && err.response?.data is Map) {
        final Map<String, dynamic> data = err.response?.data;
        statusCode = data['statusCode'];
      } else if (err.response?.data is ResponseBody) {
        final ResponseBody data = err.response!.data;
        statusCode = data.statusCode.toString();
      } else {
        statusCode = err.response?.statusCode.toString();
      }

      // if (ApiConstants.httpUnauthorizedStatusCode
      //         .contains(err.response!.statusCode) &&
      //     AppValues.unauthorizedStatusCode.toString() == statusCode) {
      //   /// Clear local storage
      //   await localRepository.clearStorage();

      /// Only redirect to Login page once
      // if ((Get.currentRoute == Routes.dashboard ||
      //         Get.currentRoute == Routes.dashboardAnimation) ||
      //     ((Get.currentRoute == Routes.dashboard ||
      //             Get.currentRoute == Routes.dashboardAnimation) &&
      //         Get.currentRoute != Routes.login) ||
      //     Get.previousRoute == Routes.outletManagement ||
      //     Get.previousRoute == Routes.userManagement ||
      //     Get.previousRoute == Routes.report) {
      // final WebsocketService websocketService =
      //     Get.find<WebsocketService>();

      // await websocketService.disconnect();

      /// force logout
      // await forceLogout();
      // }
      // }
    }
    super.onError(err, handler);
  }
}
