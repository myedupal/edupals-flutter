import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/utils/connection_checker.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:edupals/features/splash/presentation/controller/splash_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    // Register Important Service
    Get.lazyPut(() => const FlutterSecureStorage(), fenix: true);
    Get.lazyPut(() => SecureStorageService(), fenix: true);
    Get.lazyPut<ConnectionChecker>(() => ConnectionCheckerImpl(), fenix: true);
    Get.lazyPut(() => SplashController());
    Get.put(Dio(), permanent: true);
    Get.lazyPut<DioClient>(
        () => DioClientImpl(dio: Get.find(), connectionChecker: Get.find()),
        fenix: true);
    Get.lazyPut<LocalRepository>(() => LocalRepository(), fenix: true);
  }
}
