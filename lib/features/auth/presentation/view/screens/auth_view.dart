import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/auth/presentation/controller/auth_controller.dart';
import 'package:edupals/features/auth/presentation/view/components/login_form.dart';
import 'package:edupals/features/auth/presentation/view/components/register_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  Widget get _footerSegment {
    return Row(
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
        ),
      ],
    ).padding(const EdgeInsets.only(top: AppValues.double30));
  }

  Widget get _loginForm {
    return const LoginForm(
      key: ValueKey<int>(0),
    ).padding(EdgeInsets.symmetric(
        horizontal: Get.context?.isPhone == true
            ? AppValues.double30
            : AppValues.double80));
  }

  Widget get _registerForm {
    return const RegisterForm(
      key: ValueKey<int>(1),
    ).padding(EdgeInsets.symmetric(
        horizontal: Get.context?.isPhone == true
            ? AppValues.double30
            : AppValues.double80));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (!context.isPhone && context.isLandscape)
              const ImageAssetView(fileName: AppAssets.authBg),
            Expanded(
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                  Column(children: [
                    if (context.isPhone || !context.isLandscape)
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                    Text(
                      "Welcome to edupals",
                      style: MyTextStyle.xl.bold,
                    ),
                    const SizedBox(
                      height: AppValues.double40,
                    ),
                    AnimatedSize(
                      alignment: Alignment.bottomCenter,
                      duration: const Duration(milliseconds: 300),
                      child: controller.currentStep.value == AuthStep.login
                          ? _loginForm
                          : _registerForm,
                    ),
                    _footerSegment
                  ])
                ]))
          ],
        )
            .ignorePointer(controller.viewState == ViewState.loading)
            .scaffoldWrapper(topSafe: false));
  }
}
