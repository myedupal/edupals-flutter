import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class AnswerSelectionRow extends StatelessWidget {
  const AnswerSelectionRow({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "A",
          style: isActive
              ? MyTextStyle.l.bold.c(AppColors.accent500)
              : MyTextStyle.l.c(AppColors.gray700),
        ),
        Text(
          "Cambridge A-level",
          style: isActive
              ? MyTextStyle.l.bold.c(AppColors.accent500)
              : MyTextStyle.l.c(AppColors.gray700),
        ).padding(const EdgeInsets.only(left: AppValues.double15))
      ],
    )
        .capsulise(
            radius: 10,
            border: true,
            borderColor: isActive ? AppColors.accent500 : AppColors.gray200,
            padding: const EdgeInsets.symmetric(
                horizontal: AppValues.double20, vertical: AppValues.double20),
            color: isActive ? AppColors.accent100 : AppColors.white)
        .padding(const EdgeInsets.only(bottom: AppValues.double20));
  }
}
