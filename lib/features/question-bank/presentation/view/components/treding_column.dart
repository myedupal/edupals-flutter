import 'package:edupals/core/base/base_progress_indicator.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class TrendingColumn extends StatelessWidget {
  const TrendingColumn({
    super.key,
    this.percentage = 0,
    this.withProgress = true,
    this.title,
    this.value,
    this.subvalue,
    this.ableStart = true,
  });

  final int percentage;
  final bool withProgress;
  final String? title;
  final String? value;
  final String? subvalue;
  final bool ableStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "",
              style: MyTextStyle.m.bold,
            ),
            if (ableStart)
              Text(
                "Start now",
                style: MyTextStyle.xxs.bold.c(AppColors.accent500),
              ).capsulise(
                  radius: 100,
                  border: true,
                  borderColor: AppColors.accent500,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppValues.double5,
                      horizontal: AppValues.double15))
          ],
        ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
        Row(
          children: [
            Text(
              value ?? "",
              style: MyTextStyle.xxs,
            ).padding(const EdgeInsets.only(right: AppValues.double20)),
            Text(
              subvalue ?? "",
              style: MyTextStyle.xxs,
            )
          ],
        ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
        if (withProgress)
          Row(
            children: [
              Text(
                "$percentage%",
                style: MyTextStyle.xxs.bold,
              ),
              Expanded(
                  child: BaseProgressIndicator(
                color: AppColors.accent500,
                backgoundColor: AppColors.gray100,
                fixedPercentage: percentage / 100,
                height: AppValues.double8,
              ).padding(const EdgeInsets.symmetric(
                      horizontal: AppValues.double10))),
              Text(
                "$percentage/100",
                style: MyTextStyle.xxs.bold,
              )
            ],
          ).padding(const EdgeInsets.only(bottom: AppValues.double10))
      ],
    ).capsulise(
        radius: 10,
        border: true,
        color: AppColors.white.withAlpha(90),
        borderColor: AppColors.gray300,
        padding: const EdgeInsets.all(AppValues.double15));
  }
}
