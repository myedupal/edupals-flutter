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

class RegisterForm extends GetView<AuthController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BaseInput(
          label: "Name",
          controller: controller.nameController,
        ).padding(const EdgeInsets.only(bottom: AppValues.double15)),
        BaseInput(
          label: "Phone Number",
          controller: controller.phoneNumberController,
        ).padding(const EdgeInsets.only(bottom: AppValues.double15)),
        BaseInput(
          label: "Email Address",
          controller: controller.emailController,
        ).padding(const EdgeInsets.only(bottom: AppValues.double15)),
        BaseInput(
          label: "Password",
          controller: controller.passwordController,
          keyboardType: KeyboardType.password,
        ).padding(const EdgeInsets.only(bottom: AppValues.double15)),
        Obx(
          () => BaseButton(
            text: "Register",
            isLoading: controller.viewState == ViewState.loading,
            onClick: () {
              controller.register();
            },
            fullWidth: true,
          ),
        ),
        const Text(
          "By registering an account with edupals you agree to the privacy policy and terms of use of edupals",
          style: MyTextStyle.xs,
        ).padding(const EdgeInsets.only(top: AppValues.double20)),
        const BaseDivider()
            .padding(const EdgeInsets.symmetric(vertical: AppValues.double10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Already have an account?",
              style: MyTextStyle.xs,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseButton(
              text: "Sign In",
              onClick: () {
                controller.onChangeAuthStep(step: AuthStep.login);
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
