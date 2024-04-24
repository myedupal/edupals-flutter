import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/base/base_input.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<AuthController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseInput(
          label: "Email Address",
          controller: controller.emailController,
        ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
        BaseInput(
          label: "Password",
          controller: controller.passwordController,
          keyboardType: KeyboardType.password,
        ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
        Obx(() => BaseButton(
              text: "Login",
              isLoading: controller.viewState == ViewState.loading,
              onClick: () {
                controller.login();
              },
              fullWidth: true,
            )),
        const BaseDivider()
            .padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Don't have an account?",
              style: MyTextStyle.xs,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseButton(
              text: "Register",
              onClick: () {
                controller.onChangeAuthStep(step: AuthStep.register);
              },
              fullWidth: true,
              type: ButtonType.white,
            )
          ],
        ),
      ],
    );
  }
}
