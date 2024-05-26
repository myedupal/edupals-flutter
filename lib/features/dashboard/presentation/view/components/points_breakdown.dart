import 'package:edupals/core/base/base_horizontal_bar_chart.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/profile_picture.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/dashboard/presentation/controller/dashborad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointsBreakdown extends GetView<DashboardController> {
  const PointsBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Row(
              children: [
                const ProfilePicture(
                  size: AppValues.double30,
                ).padding(const EdgeInsets.only(right: AppValues.double5)),
                Text(
                  "${mainController.currentUser.value?.name}",
                  style: MyTextStyle.m.bold.c(AppColors.white),
                )
              ],
            )),
        Row(
          children: [
            const ImageAssetView(fileName: AppAssets.blueCrown),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Points Earned",
                  style: MyTextStyle.m.bold.c(AppColors.white),
                ),
                Obx(() => Text(
                      "${controller.pointReport.value?.totalPoints ?? 0}",
                      style: MyTextStyle.m.regular.c(AppColors.white),
                    ))
              ],
            ).padding(const EdgeInsets.only(left: AppValues.double20))
          ],
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
        Obx(() {
          final pointReport = controller.pointReport.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Points earned breakdown",
                style: MyTextStyle.s.bold.c(AppColors.white),
              ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
              if (pointReport != null)
                BaseHorizontalBarChart(
                  dylabels: const ["MCQ", "Daily Challenge", "Daily Check In"],
                  dxlabels: List<int>.generate(
                      8,
                      (index) => ((index) *
                          ((((pointReport.totalPoints ?? 8) < 10)
                                      ? 8
                                      : (pointReport.totalPoints ?? 8)) /
                                  8)
                              .round())),
                  data: [
                    double.parse("${pointReport.mcqPoints ?? 0.0}"),
                    double.parse("${pointReport.dailyChallengePoints ?? 0.0}"),
                    double.parse("${pointReport.dailyCheckInPoints ?? 0.0}"),
                  ],
                  leftRatio: context.isTabletLandscape ? 0.25 : 0.20,
                  rightRatio: context.isTabletLandscape ? 0.75 : 0.80,
                )
            ],
          );
        })
      ],
    ).capsulise(
        radius: 10,
        color: AppColors.accent500,
        padding: const EdgeInsets.all(AppValues.double20));
  }
}
