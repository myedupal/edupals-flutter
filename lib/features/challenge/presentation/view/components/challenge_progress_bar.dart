import 'package:edupals/core/base/base_progress_indicator.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/controller/challenge_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeProgressBar extends GetView<ChallengeDetailsController> {
  const ChallengeProgressBar({
    super.key,
    required this.currentQuestionNumber,
    required this.totalQuestionNumber,
    required this.time,
  });

  final int currentQuestionNumber;
  final int totalQuestionNumber;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ImageAssetView(
          fileName: AppAssets.leftChevron,
          height: AppValues.double15,
          color: AppColors.white,
        )
            .capsulise(
                radius: 100,
                color: AppColors.accent500,
                padding: const EdgeInsets.all(AppValues.double10))
            .padding(const EdgeInsets.only(right: AppValues.double10))
            .onTap(() {
          controller.onBack();
        }),
        Expanded(
            child: Row(
          children: [
            Text(
              time,
              style: MyTextStyle.s.bold,
            ).padding(
                const EdgeInsets.symmetric(horizontal: AppValues.double10)),
            Expanded(
                child: BaseProgressIndicator(
                    color: AppColors.accent500,
                    backgoundColor: AppColors.gray100,
                    fixedPercentage:
                        currentQuestionNumber / totalQuestionNumber)),
            Text(
              "$currentQuestionNumber / $totalQuestionNumber",
              style: MyTextStyle.s.bold,
            ).padding(
                const EdgeInsets.symmetric(horizontal: AppValues.double10))
          ],
        ).capsulise(
          radius: 100,
          color: AppColors.white,
          padding: const EdgeInsets.all(AppValues.double12),
        )),
        const ImageAssetView(
          fileName: AppAssets.rightChevron,
          height: AppValues.double15,
          color: AppColors.white,
        )
            .capsulise(
                radius: 100,
                color: AppColors.accent500,
                padding: const EdgeInsets.all(AppValues.double10))
            .padding(const EdgeInsets.only(left: AppValues.double10))
            .onTap(() {
          controller.nextQuestion();
        }),
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
