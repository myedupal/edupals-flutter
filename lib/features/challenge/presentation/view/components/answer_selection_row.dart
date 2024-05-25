import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class AnswerSelectionRow extends StatelessWidget {
  const AnswerSelectionRow({
    super.key,
    this.isActive = false,
    this.isFull = false,
    this.isCorrect = false,
    this.isWrong = false,
    this.title,
  });

  final bool isActive;
  final bool isFull;
  final bool isCorrect;
  final bool isWrong;
  final String? title;

  Color get getTextColor {
    Color textColor = AppColors.gray700;

    if (isActive) {
      textColor = AppColors.accent500;
    }

    if (isCorrect) {
      textColor = AppColors.green500;
    }

    if (isWrong) {
      textColor = AppColors.pink500;
    }

    return textColor;
  }

  Color get getBackgroundColor {
    Color backgroundColor = AppColors.white.withAlpha(90);

    if (isActive) {
      backgroundColor = AppColors.accent100;
    }

    if (isCorrect) {
      backgroundColor = AppColors.green100;
    }

    if (isWrong) {
      backgroundColor = AppColors.pink50;
    }

    return backgroundColor;
  }

  Color get getBorderColor {
    Color borderColor = AppColors.gray200;

    if (isActive) {
      borderColor = AppColors.accent500;
    }

    if (isCorrect) {
      borderColor = AppColors.green500;
    }

    if (isWrong) {
      borderColor = AppColors.red500;
    }

    return borderColor;
  }

  bool get isBold => isActive || isCorrect || isWrong;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFull ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Text(
          title ?? "",
          style: isBold
              ? MyTextStyle.m.bold.c(getTextColor)
              : MyTextStyle.m.c(getTextColor),
        ),
        if (isFull)
          Text(
            "Cambridge A-level",
            style: isBold
                ? MyTextStyle.m.bold.c(getTextColor)
                : MyTextStyle.m.c(getTextColor),
          ).padding(const EdgeInsets.only(left: AppValues.double15))
      ],
    )
        .capsulise(
            radius: 10,
            border: true,
            borderColor: getBorderColor,
            padding: const EdgeInsets.symmetric(vertical: AppValues.double20),
            color: getBackgroundColor)
        .padding(const EdgeInsets.only(bottom: AppValues.double20));
  }
}
