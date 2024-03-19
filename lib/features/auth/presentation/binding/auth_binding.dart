import 'package:edupals/features/auth/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register repository
    // Register controller
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
