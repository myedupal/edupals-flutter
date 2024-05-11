import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

extension CustomExtension on BuildContext {
  bool get isPhonePortrait => isPhone || isPortrait;
}

extension CustomGet on GetInterface {
  double get dynamicWidth => Get.width > Get.height ? Get.width : Get.height;
}
