import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/repositories/local_repository.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthStep { register, login }

class AuthController extends BaseController {
  final AuthRepository authRepo = Get.find();
  final MainController mainController = Get.find();
  final LocalRepository localRepo = Get.find();
  final Rx<AuthStep> currentStep = AuthStep.login.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool validLoginInput() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      BaseDialog.showError(subtitle: "Emaill and password cannot be empty.");
      return false;
    }
    return true;
  }

  bool validRegisterInput() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      BaseDialog.showError(subtitle: "All fields are required.");
      return false;
    }
    return true;
  }

  void onChangeAuthStep({required AuthStep step}) {
    currentStep.value = step;
  }

  Future<void> login() async {
    if (validLoginInput()) {
      setLoading();
      await authRepo.login(
          user: User(
              email: emailController.value.text,
              password: passwordController.value.text),
          onSuccess: (value) {
            setSuccess();
            mainController.setUser(user: value);
            mainController.goAhead();
            Get.offAllNamed(Routes.homeAnimation);
          },
          onError: (error) {
            setSuccess();
            BaseDialog.showError(subtitle: error.message);
          });
    }
  }

  Future<void> loginWithGoogle({required String idToken}) async {
    setLoading();
    mainController.setJwtToken(token: idToken);
    await authRepo.googleLogin(
        idToken: idToken,
        onSuccess: (value) {
          setSuccess();
          mainController.setUser(
              user: value?.user, salt: value?.meta?.zkloginSalt);
          mainController.goAhead();
          Get.offAllNamed(Routes.homeAnimation);
        },
        onError: (error) {
          setSuccess();
          BaseDialog.showError(subtitle: error.message);
        });
  }

  Future<void> register() async {
    if (validRegisterInput()) {
      setLoading();
      await authRepo.register(
          user: User(
              name: nameController.value.text,
              email: emailController.value.text,
              password: passwordController.value.text),
          onSuccess: (value) {
            setSuccess();
            BaseDialog.showSuccess(
              dismissable: false,
              message: "Your account is registered successfully",
              buttonText: "Go to dashboard",
              action: () {
                mainController.goAhead();
                Get.offAllNamed(Routes.homeAnimation);
              },
            );
          },
          onError: (error) {
            setSuccess();
            BaseDialog.showError(subtitle: error.message);
          });
    }
  }
}
