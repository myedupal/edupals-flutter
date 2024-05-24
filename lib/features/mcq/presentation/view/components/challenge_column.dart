import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeColumn extends StatelessWidget {
  const ChallengeColumn({super.key, this.challenge});

  final Challenge? challenge;

  Widget displayRow({required String icon, String? title}) {
    return Row(
      children: [
        ImageAssetView(
          fileName: icon,
          width: AppValues.double20,
          height: AppValues.double20,
        ),
        Text(
          "$title",
          style: MyTextStyle.xs.bold,
        ).padding(const EdgeInsets.only(left: AppValues.double5))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              "Challenge",
              style: MyTextStyle.m.bold,
            )),
            Text(
              "Start now",
              style: MyTextStyle.xxs.bold.c(AppColors.gray900),
            ).capsulise(
                radius: 100,
                border: true,
                borderColor: AppColors.gray400,
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                    vertical: AppValues.double5,
                    horizontal: AppValues.double15))
          ],
        ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayRow(icon: AppAssets.blueCircle, title: "120m 5s"),
            displayRow(icon: AppAssets.darkOrangeCrown, title: "30/40"),
            displayRow(icon: AppAssets.wrong, title: "3 to improve"),
          ],
        )
            .padding(const EdgeInsets.symmetric(horizontal: AppValues.double5))
            .capsulise(
                radius: 100,
                color: AppColors.white,
                padding: const EdgeInsets.all(AppValues.double10))
      ],
    ).capsulise(
        radius: 10,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double15));
  }
}
