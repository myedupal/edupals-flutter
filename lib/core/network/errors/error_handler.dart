import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  BaseFailure handleDioError(dio.DioException dioError, StackTrace stackTrace) {
    if (kDebugMode) {
      print('dioErrorStatusCode: ${dioError.response?.statusCode}');
      print('dioError: ${dioError.toString()}');
      // print('stackTrace: $stackTrace');
      print('message: ${dioError.message}');
    }

    switch (dioError.type) {
      case dio.DioExceptionType.badResponse:
        return _parseApiErrorResponse(dioError.response);

      case dio.DioExceptionType.connectionError:
        return GeneralFailure(message: "No internet connection");

      default:
        return GeneralFailure(
          message: "Something went wrong. Please try again later",
          statusCode: dioError.response?.statusCode,
        );
    }
  }

  BaseFailure unHandledError(String error, StackTrace? stackTrace) {
    final logger = FlavorConfig.instance.logger;
    logger.e('Unhandled exception: $error\n$stackTrace');

    return GeneralFailure(message: error);
  }

  BaseFailure _parseApiErrorResponse(dio.Response? response) {
    final Logger logger = FlavorConfig.instance.logger;

    // -1 is just a fancy way of saying the statusCode is not found
    int? statusCode = -1;
    String? serverMessage = '';

    try {
      statusCode = response?.statusCode ?? -1;
      if (response?.data is Map<String, dynamic>) {
        Map<String, dynamic> data = response?.data;

        if (data.containsKey("error_messages")) {
          serverMessage = data["error_messages"][0];
        }
      }
      // serverMessage = response?.data != null
      //     ? response?.data['error_messages'][0] ?? ""
      //     : "";
    } catch (e, s) {
      logger.i('$e');
      logger.i(s.toString());

      if (e is FormatException) {
        return GeneralFailure(message: e.message);
      }

      statusCode = response?.statusCode;

      serverMessage = e.toString();
    }

    return ApiFailure(
        message: serverMessage ?? '', statusCode: statusCode, extra: null);
  }

  Future forceLogout() async {
    final LocalRepository localRepository = Get.find<LocalRepository>();

    await localRepository.clearStorage();

    await Get.offAllNamed(Routes.login);
  }
}
