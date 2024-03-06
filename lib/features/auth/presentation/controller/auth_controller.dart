import 'package:edupals/core/base/base_snackbar.dart';
import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository authRepo = Get.find();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    await authRepo.login(
        user: User(
            email: emailController.value.text,
            password: passwordController.value.text),
        onSuccess: (value) {
          Get.offAllNamed(Routes.home);
        },
        onError: (error) {
          BaseSnackBar.show(message: error.message);
        });
  }
}
