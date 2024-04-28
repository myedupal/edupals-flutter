import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/routing.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final LocalRepository localRepo = Get.find();

  @override
  void onInit() {
    checkLogin();
    Future.delayed(const Duration(seconds: 2), () {
      if (isLoggedIn.value) {
        Get.offAllNamed(Routes.homeAnimation);
      } else {
        Get.offAllNamed(Routes.loginAnimation);
      }
    });
    super.onInit();
  }

  void checkLogin() async {
    final String? accessToken = await localRepo.getAccessToken();
    isLoggedIn.value = accessToken != null && accessToken.isNotEmpty;
  }
}
