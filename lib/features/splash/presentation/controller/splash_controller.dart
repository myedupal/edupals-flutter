import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/routing.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import 'package:zklogin/zklogin.dart';

class SplashController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final AuthRepository authRepo = Get.find();
  final MainController mainController = Get.find();
  final LocalRepository localRepo = Get.find();

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  void checkLogin() async {
    final url = html.window.location.href;
    final String? accessToken = await localRepo.getAccessToken();
    isLoggedIn.value = accessToken != null && accessToken.isNotEmpty;
    // Check for web url first
    if (!isLoggedIn.value &&
        url.startsWith(FlavorConfig.replaceUrl) &&
        kIsWeb) {
      String temp = url.replaceAll(FlavorConfig.replaceUrl, '');
      String jwt = temp.substring(0, temp.indexOf('&'));
      debugPrint("Decode JWt ${decodeJwt(jwt)}");
      loginWithGoogle(idToken: jwt);
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        if (isLoggedIn.value) {
          mainController.goAhead();
          Get.offAllNamed(Routes.homeAnimation);
        } else {
          Get.offAllNamed(Routes.loginAnimation);
        }
      });
    }
  }

  // For web redirect login
  Future<void> loginWithGoogle({required String idToken}) async {
    mainController.setJwtToken(token: idToken);
    await authRepo.googleLogin(
        idToken: idToken,
        onSuccess: (value) {
          mainController.setUser(
              user: value?.user, salt: value?.meta?.zkloginSalt);
          mainController.goAhead();
          Get.offAllNamed(Routes.homeAnimation);
          html.window.history.pushState({}, '', '');
        },
        onError: (error) {
          BaseDialog.showError(subtitle: error.message);
        });
  }
}
