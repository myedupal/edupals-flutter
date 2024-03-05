import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/base/base_input.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
            const BaseInput(
              label: "Email Address",
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            const BaseInput(
              label: "Password",
              keyboardType: KeyboardType.password,
            ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
            BaseButton(
              text: "Login",
              onClick: () {
                Get.offAllNamed(Routes.home);
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
    return Row(
      children: [
        const ImageAssetView(fileName: AppAssets.authBg),
        Expanded(child: _loginForm)
      ],
    ).scaffoldWrapper(topSafe: false);
  }
}
