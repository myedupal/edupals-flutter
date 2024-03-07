import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:flutter/material.dart';

class QuestionsListColumn extends StatelessWidget {
  const QuestionsListColumn(
      {super.key, required this.question, this.isActive = false});

  final Question question;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Q${question.number}",
          style: MyTextStyle.xs.bold
              .c(isActive ? AppColors.white : AppColors.gray900),
        ).capsulise(
            color: isActive ? AppColors.accent500 : AppColors.gray100,
            padding: const EdgeInsets.symmetric(
                horizontal: AppValues.double8, vertical: AppValues.double6)),
        Text(
          "${question.exam?.year}-${question.exam?.season}-${question.exam?.zone}",
          style: MyTextStyle.s.bold
              .c(isActive ? AppColors.accent500 : AppColors.gray900),
        ).padding(const EdgeInsets.only(left: AppValues.double10))
      ],
    ).capsulise(
        radius: 15,
        color: isActive ? AppColors.gray100 : AppColors.white,
        padding: const EdgeInsets.symmetric(
            vertical: AppValues.double15, horizontal: AppValues.double15));
  }
}
