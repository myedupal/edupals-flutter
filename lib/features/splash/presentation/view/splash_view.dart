import 'package:edupals/features/splash/presentation/controller/splash_controller.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container().scaffoldWrapper();
  }
}
