import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key, this.challenge, this.onClick});

  final Challenge? challenge;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${challenge?.subject?.name}",
              style: MyTextStyle.xl.bold.c(AppColors.white),
            ),
            const ImageAssetView(
              fileName: AppAssets.rightFullChevron,
              width: AppValues.double10,
              height: AppValues.double10,
            ).capsulise(
                radius: 100,
                color: AppColors.white,
                padding: const EdgeInsets.all(AppValues.double15))
          ],
        ),
        Row(
          children: [
            Text(
              "All chapters",
              style: MyTextStyle.xs.bold.c(AppColors.white),
            ).capsulise(
                radius: 10,
                color: AppColors.gray900.withAlpha(200),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.double10, vertical: 5)),
            Text(
              "10 questions",
              style: MyTextStyle.xs.bold.c(AppColors.white),
            )
                .capsulise(
                    radius: 10,
                    color: AppColors.gray900.withAlpha(200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.double10, vertical: 5))
                .padding(const EdgeInsets.only(left: AppValues.double10))
          ],
        )
      ],
    )
        .imageBackground(
      image: challenge?.subject?.getBackgroundImage,
      radius: 20,
    )
        .onTap(() {
      onClick?.call();
    });
  }
}
