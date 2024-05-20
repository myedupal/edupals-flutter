import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class DashboardColumn extends StatelessWidget {
  const DashboardColumn(
      {super.key, this.title, this.childWidget, this.childValue});

  final String? title;
  final String? childValue;
  final Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
            height: Get.dynamicWidth * 0.14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: MyTextStyle.s.bold,
                ),
                const Spacer(),
                (childWidget ??
                    Text(
                      childValue ?? "",
                      style: MyTextStyle.xl2.medium,
                    )),
              ],
            )
                .capsulise(
                    radius: 15,
                    color: AppColors.white,
                    padding: const EdgeInsets.all(AppValues.double20))
                .padding(const EdgeInsets.only(right: AppValues.double10))));
  }
}
