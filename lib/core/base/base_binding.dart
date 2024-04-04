import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/utils/connection_checker.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:edupals/features/dashboard/domain/repository/curriculum_repository.dart';
import 'package:edupals/features/history/domain/repository/activity_question_repository.dart';
import 'package:edupals/features/history/domain/repository/activity_repository.dart';
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

    // Register Repository
    Get.lazyPut<LocalRepository>(() => LocalRepository(), fenix: true);
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => CurriculumRepository());
    Get.lazyPut<ActivityQuestionRepository>(() => ActivityQuestionRepository(),
        fenix: true);
    Get.lazyPut<ActivityRepository>(() => ActivityRepository(), fenix: true);

    // Controller
    Get.put<MainController>(MainController(), permanent: true);
  }
}
