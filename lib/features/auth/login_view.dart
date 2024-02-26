import 'package:edupals/core/base/base_input.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  Widget get _loginForm {
    return ListView(
      children: [
        const SizedBox(
          height: AppValues.double100,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to edupals",
              style: MyTextStyle.h3,
            ),
            SizedBox(
              height: AppValues.double40,
            ),
            BaseInput(
              label: "How do we address you?",
            )
          ],
        ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double80))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const ImageAssetView(fileName: AppAssets.authBg),
        Expanded(child: _loginForm)
      ],
    ).scaffoldWrapper();
  }
}
