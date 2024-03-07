import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutTopBar extends StatelessWidget {
  const LayoutTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageAssetView(fileName: AppAssets.appIcon).padding(
            const EdgeInsets.only(
                left: AppValues.double10, right: AppValues.double20)),
        Row(children: [
          Text(
            "Cambridge IGCSE",
            style: MyTextStyle.s.bold,
          ),
          const ImageAssetView(fileName: AppAssets.downChevron)
              .padding(const EdgeInsets.only(left: AppValues.double10))
        ]).capsulise(
            radius: 100,
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(
                vertical: AppValues.double10, horizontal: AppValues.double10)),
        const Spacer(),
        Row(
          children: [
            Text(
              "LV.13",
              style: MyTextStyle.xxs.bold.c(AppColors.white),
            ).onTap(() {
              Get.find<MainController>().logout();
            })
          ],
        ).capsulise(
            radius: 100,
            color: AppColors.accent500,
            padding: const EdgeInsets.symmetric(
                horizontal: AppValues.double10, vertical: AppValues.double10))
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
