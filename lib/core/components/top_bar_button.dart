import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class TopBarButton extends StatelessWidget {
  const TopBarButton(
      {super.key, this.trailingWidget, this.title, this.leadingWidget});

  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final String? title;

  bool get isWidget => trailingWidget != null || leadingWidget != null;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingWidget ?? Container(),
        Text(
          title ?? "",
          style: MyTextStyle.s.bold.c(AppColors.white),
        ),
        trailingWidget ?? Container()
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.accent500,
        padding: EdgeInsets.symmetric(
            horizontal: isWidget ? AppValues.double10 : AppValues.double15,
            vertical: isWidget ? AppValues.double10 : AppValues.double12));
  }
}
