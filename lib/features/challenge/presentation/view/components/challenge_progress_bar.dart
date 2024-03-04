import 'package:edupals/core/base/base_progress_indicator.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeProgressBar extends StatelessWidget {
  const ChallengeProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ImageAssetView(
          fileName: AppAssets.backIcon,
          height: AppValues.double15,
          color: AppColors.gray900,
        )
            .capsulise(
                radius: 100,
                color: AppColors.gray100,
                padding: const EdgeInsets.all(AppValues.double15))
            .padding(const EdgeInsets.only(right: AppValues.double10))
            .onTap(() {
          Get.back();
        }),
        const Expanded(
            child: BaseProgressIndicator(
                color: AppColors.accent500,
                backgoundColor: AppColors.gray100,
                fixedPercentage: 0.4)),
        Transform.translate(
          offset: const Offset(-5, 0),
          child: const ImageAssetView(
            fileName: AppAssets.appIcon,
            width: AppValues.double20,
          ).capsulise(
              radius: 100,
              color: AppColors.gray100,
              padding: const EdgeInsets.all(AppValues.double15)),
        ),
      ],
    );
  }
}
