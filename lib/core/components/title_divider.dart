import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  const TitleDivider(
      {super.key, this.displayDivider = true, this.title, this.titleStyle});

  final bool displayDivider;
  final String? title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? "",
          style: titleStyle ?? MyTextStyle.s.bold,
        ).padding(const EdgeInsets.symmetric(
            vertical: AppValues.double5, horizontal: AppValues.double5)),
        if (displayDivider)
          const VerticalDivider(
            thickness: 1,
            color: AppColors.gray400,
          )
      ],
    );
  }
}
