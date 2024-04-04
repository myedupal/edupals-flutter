import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:flutter/material.dart';

class QuestionsListColumn extends StatelessWidget {
  const QuestionsListColumn({
    super.key,
    required this.question,
    this.isActive = false,
    this.isAddActive = false,
    this.ableAdd = false,
    this.onTap,
    this.onAddTap,
  });

  final Question question;
  final bool isActive;
  final bool isAddActive;
  final bool ableAdd;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Q${question.number}",
              style: MyTextStyle.xs.bold
                  .c(isActive ? AppColors.white : AppColors.gray900),
            ).capsulise(
                color: isActive ? AppColors.accent500 : AppColors.gray100,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.double8,
                    vertical: AppValues.double6)),
            Text(
              "${question.exam?.year}-${question.exam?.season}-${question.exam?.zone}",
              style: MyTextStyle.s.bold
                  .c(isActive ? AppColors.accent500 : AppColors.gray900),
            ).padding(const EdgeInsets.only(left: AppValues.double10)),
          ],
        ),
        if (ableAdd)
          ImageAssetView(
            fileName: isAddActive ? AppAssets.check : AppAssets.addIcon,
            height: AppValues.double15,
            width: AppValues.double15,
            color: AppColors.accent500,
          )
              .capsulise(
                  radius: 100,
                  padding: const EdgeInsets.all(AppValues.double10),
                  color: isActive ? AppColors.white : AppColors.gray100)
              .onTap(() {
            onAddTap?.call();
          })
      ],
    )
        .capsulise(
            radius: 15,
            color: isActive ? AppColors.gray100 : AppColors.white,
            padding: const EdgeInsets.symmetric(
                vertical: AppValues.double15, horizontal: AppValues.double15))
        .onTap(() {
      onTap?.call();
    });
  }
}
