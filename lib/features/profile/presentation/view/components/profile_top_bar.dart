import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageAssetView(fileName: AppAssets.appIcon).padding(
            const EdgeInsets.only(
                left: AppValues.double10, right: AppValues.double20)),
        const Spacer(),
        Text("Back", style: MyTextStyle.s.bold.c(AppColors.white))
            .topBarCapsule()
            .onTap(() {
          Get.back();
        }),
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
