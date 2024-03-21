import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/dashboard/presentation/view/components/challenge_banner.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetResponsiveView<MainController> {
  DashboardView({super.key}) : super(alwaysUseBuilder: false);

  Widget dashboardColumn({String? title, String? value, String? subvalue}) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: MyTextStyle.s.bold,
        ),
        const Spacer(),
        Text(
          value ?? "",
          style: MyTextStyle.xl2.medium,
        ).padding(const EdgeInsets.only(top: AppValues.double30)),
      ],
    )
            .capsulise(
                radius: 15,
                color: AppColors.gray100,
                padding: const EdgeInsets.all(AppValues.double20))
            .padding(const EdgeInsets.only(right: AppValues.double10)));
  }

  @override
  Widget builder() => Column(
        children: [
          const ChallengeBanner(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 8,
                  child: IntrinsicHeight(
                      child: Row(
                    children: [
                      dashboardColumn(
                          title: "Average time spent 10 questions",
                          value: "100"),
                      dashboardColumn(
                          title: "Total question attempt", value: "100/100"),
                      dashboardColumn(title: "Accuracy", value: "50/100"),
                      dashboardColumn(title: "Question flagged", value: "100"),
                    ],
                  ))),
              Expanded(flex: 3, child: Container())
            ],
          ).padding(const EdgeInsets.only(top: AppValues.double20))
        ],
      );
}
