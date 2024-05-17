import 'package:edupals/config/flavor_config.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/routing.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import 'package:zklogin/zklogin.dart';

class SplashController extends GetxController {
  final RxBool isLoggedIn = false.obs;
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
    if (!isLoggedIn.value &&
        url.startsWith(FlavorConfig.replaceUrl) &&
        kIsWeb) {
      String temp = url.replaceAll(FlavorConfig.replaceUrl, '');
      String jwt = temp.substring(0, temp.indexOf('&'));
      debugPrint("Decode JWt ${decodeJwt(jwt)}");
      // Handle login
      // html.window.location.href = Uri.base.origin;
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        if (isLoggedIn.value) {
          Get.offAllNamed(Routes.homeAnimation);
        } else {
          Get.offAllNamed(Routes.loginAnimation);
        }
      });
    }
  }
}
