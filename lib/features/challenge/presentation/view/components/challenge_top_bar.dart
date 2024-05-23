import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
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
    final MainController mainController = Get.find();
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
            if (!context.isPhonePortrait)
              Row(children: [
                const ImageAssetView(
                  fileName: AppAssets.orangeCrown,
                  width: AppValues.double25,
                  height: AppValues.double25,
                ).padding(const EdgeInsets.only(right: AppValues.double5)),
                Text(
                  "Today's Challenge",
                  style: MyTextStyle.s.bold,
                )
              ]).topBarWidgetCapsule(color: AppColors.white),
          ],
        )),
        // if (!context.isPhone)
        Row(
          children: [
            const ImageAssetView(
              fileName: AppAssets.diamond,
            ).padding(const EdgeInsets.only(right: AppValues.double5)),
            Text(
              "${mainController.currentUser.value?.points ?? 0} PTS",
              style: MyTextStyle.xs.extraBold,
            ),
            const SizedBox(
              width: AppValues.double10,
            ),
            const ImageAssetView(
              fileName: AppAssets.fire,
            ).padding(const EdgeInsets.only(right: AppValues.double5)),
            Text(
              "${mainController.currentUser.value?.dailyStreak ?? 0} Streak",
              style: MyTextStyle.xs.extraBold,
            )
          ],
        )
            .padding(const EdgeInsets.symmetric(horizontal: AppValues.double5))
            .topBarWidgetCapsule(color: AppColors.white)
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
