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

  @override
  Widget builder() => Column(
        children: [
          const ChallengeBanner(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Question Flagged",
                              style: MyTextStyle.s.bold,
                            ),
                            Text(
                              "100",
                              style: MyTextStyle.xl2.medium,
                            ).padding(
                                const EdgeInsets.only(top: AppValues.double30)),
                          ],
                        )
                                .capsulise(
                                    radius: 15,
                                    color: AppColors.gray100,
                                    padding: const EdgeInsets.all(
                                        AppValues.double20))
                                .padding(const EdgeInsets.only(
                                    right: AppValues.double10))),
                    ],
                  )),
              Expanded(flex: 3, child: Container())
            ],
          ).padding(const EdgeInsets.only(top: AppValues.double20))
        ],
      );
}
