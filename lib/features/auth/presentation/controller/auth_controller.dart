import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends BaseController {
  final AuthRepository authRepo = Get.find();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validInput() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      BaseDialog.showError(subtitle: "Emaill and password cannot be empty.");
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (validInput()) {
      setLoading();
      await authRepo.login(
          user: User(
              email: emailController.value.text,
              password: passwordController.value.text),
          onSuccess: (value) {
            setSuccess();
            Get.offAllNamed(Routes.home);
          },
          onError: (error) {
            setSuccess();
            BaseDialog.showError(subtitle: error.message);
          });
    }
  }
}
