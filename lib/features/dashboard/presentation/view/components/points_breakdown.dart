import 'package:edupals/core/base/base_horizontal_bar_chart.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
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
                ImageAssetView(
                  fileName: mainController
                          .currentUser.value?.oauth2ProfilePictureUrl ??
                      "https://images.pexels.com/photos/264905/pexels-photo-264905.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  fit: BoxFit.cover,
                  width: AppValues.double30,
                  height: AppValues.double30,
                )
                    .clip()
                    .padding(const EdgeInsets.only(right: AppValues.double5)),
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
                      7,
                      (index) => ((index) *
                          ((pointReport.totalPoints ?? 0) / 7).ceil())),
                  data: [
                    double.parse("${pointReport.mcqPoints ?? 0.0}"),
                    double.parse("${pointReport.dailyChallengePoints ?? 0.0}"),
                    double.parse("${pointReport.dailyCheckInPoints ?? 0.0}"),
                  ],
                  leftRatio: 0.20,
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
