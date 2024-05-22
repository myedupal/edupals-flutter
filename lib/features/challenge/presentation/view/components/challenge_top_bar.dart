import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeTopBar extends StatelessWidget {
  const ChallengeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            const ImageAssetView(
              fileName: AppAssets.backIcon,
              height: AppValues.double12,
            )
                .capsulise(
                    radius: 100,
                    color: AppColors.gray900,
                    padding: const EdgeInsets.all(AppValues.double12))
                .padding(const EdgeInsets.only(right: AppValues.double10))
                .onTap(() {
              Get.back();
            }),
            Row(children: [
              Text(
                "Today's Challenge",
                style: MyTextStyle.s.bold,
              )
            ]).capsulise(
                radius: 100,
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: AppValues.double10,
                    horizontal: AppValues.double15)),
          ],
        )),
        if (!context.isPhone)
          Row(
            children: [
              Text(
                "0 PTS",
                style: MyTextStyle.xs.extraBold,
              )
            ],
          ).topBarWidgetCapsule(color: AppColors.white)
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
