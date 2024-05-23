import 'package:edupals/core/base/base_progress_indicator.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class ChallengeProgressBar extends StatelessWidget {
  const ChallengeProgressBar(
      {super.key,
      required this.currentQuestionNumber,
      required this.totalQuestionNumber,
      this.onBack});

  final int currentQuestionNumber;
  final int totalQuestionNumber;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
              onBack?.call();
            }),
            Expanded(
                child: BaseProgressIndicator(
                    color: AppColors.accent500,
                    backgoundColor: AppColors.gray100,
                    fixedPercentage:
                        currentQuestionNumber / totalQuestionNumber)),
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
        ),
        Text(
          "$currentQuestionNumber / $totalQuestionNumber",
          style: MyTextStyle.s.bold.c(AppColors.accent500),
        )
      ],
    );
  }
}
