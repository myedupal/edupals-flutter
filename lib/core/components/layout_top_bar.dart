import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/point_streak_display.dart';
import 'package:edupals/core/components/profile_picture.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutTopBar extends GetView<MainController> {
  const LayoutTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!context.isPhone)
          const ImageAssetView(fileName: AppAssets.appIcon).padding(
              const EdgeInsets.only(
                  left: AppValues.double10, right: AppValues.double20)),
        Obx(() {
          final selectedCurriculum = controller.selectedCurriculum.value;
          return Row(children: [
            Text(
              selectedCurriculum != null
                  ? selectedCurriculum.getFullName
                  : "Select A Curriculum",
              style: MyTextStyle.s.bold,
            ),
            const ImageAssetView(fileName: AppAssets.downChevron)
                .padding(const EdgeInsets.only(left: AppValues.double10))
          ]).topBarWidgetCapsule(color: AppColors.white).onTap(() {
            controller.showCurriculumDialog();
          });
        }),
        const Spacer(),
        const PointStreakDisplay()
            .padding(const EdgeInsets.only(right: AppValues.double10)),
        const ProfilePicture(
          size: AppValues.double30,
        ).onTap(() {
          Get.toNamed(Routes.profile);
        }),
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
