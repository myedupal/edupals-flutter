import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/base/base_input.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  Widget get _loginForm {
    return ListView(
      children: [
        const SizedBox(
          height: AppValues.double100,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to edupals",
              style: MyTextStyle.xl.bold,
            ),
            const SizedBox(
              height: AppValues.double40,
            ),
            BaseInput(
              label: "Email Address",
              controller: controller.emailController,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseInput(
              label: "Password",
              controller: controller.passwordController,
              keyboardType: KeyboardType.password,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseButton(
              text: "Login",
              isLoading: controller.viewState == ViewState.loading,
              onClick: () {
                controller.login();
              },
              fullWidth: true,
            ),
            const BaseDivider().padding(
                const EdgeInsets.symmetric(vertical: AppValues.double20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Don't have an account?",
                  style: MyTextStyle.xs,
                ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
                BaseButton(
                  text: "Register",
                  onClick: () {},
                  fullWidth: true,
                  type: ButtonType.white,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Home",
                  style: MyTextStyle.xs,
                ).padding(const EdgeInsets.only(right: AppValues.double20)),
                const Text(
                  "FAQ",
                  style: MyTextStyle.xs,
                ).padding(const EdgeInsets.only(right: AppValues.double20)),
                const Text(
                  "Privacy Policy",
                  style: MyTextStyle.xs,
                ).padding(const EdgeInsets.only(right: AppValues.double20)),
                const Text(
                  "Terms",
                  style: MyTextStyle.xs,
                )
              ],
            ).padding(const EdgeInsets.only(top: AppValues.double30))
          ],
        ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double80))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            const ImageAssetView(fileName: AppAssets.authBg),
            Expanded(child: _loginForm)
          ],
        )
            .ignorePointer(controller.viewState == ViewState.loading)
            .scaffoldWrapper(topSafe: false));
  }
}
