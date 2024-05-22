import 'package:edupals/core/base/base_horizontal_bar_chart.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointsBreakdown extends StatelessWidget {
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
            const ImageAssetView(fileName: AppAssets.totalPointsEarned),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Points Earned",
                  style: MyTextStyle.m.bold.c(AppColors.white),
                ),
                Obx(() => Text(
                      "${mainController.currentUser.value?.points}",
                      style: MyTextStyle.m.regular.c(AppColors.white),
                    ))
              ],
            ).padding(const EdgeInsets.only(left: AppValues.double20))
          ],
        ).padding(const EdgeInsets.symmetric(vertical: AppValues.double20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Points earned breakdown",
              style: MyTextStyle.s.bold.c(AppColors.white),
            ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
            BaseHorizontalBarChart(
              dylabels: const ["MCQ", "Daily Challenge"],
              dxlabels: const [0, 10, 20, 30, 40, 50, 60, 70],
              data: const [0, 0],
              leftRatio: context.isPhonePortrait ? 0.18 : 0.25,
            )
          ],
        )
      ],
    ).capsulise(
        radius: 10,
        color: AppColors.accent500,
        padding: const EdgeInsets.all(AppValues.double20));
  }
}
