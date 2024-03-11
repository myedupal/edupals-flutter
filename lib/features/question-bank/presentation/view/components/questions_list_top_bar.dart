import 'package:collection/collection.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsListTopBar extends StatelessWidget {
  const QuestionsListTopBar({super.key, this.titleList});

  final List<String>? titleList;

  Widget titleRow({String? title, bool displayDivider = true}) => Row(
        children: [
          Text(
            title ?? "",
            style: MyTextStyle.s.bold,
          ).padding(const EdgeInsets.symmetric(
              vertical: AppValues.double5, horizontal: AppValues.double5)),
          if (displayDivider)
            const VerticalDivider(
              thickness: 1,
              color: AppColors.gray400,
            )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            const ImageAssetView(
              fileName: AppAssets.backIcon,
              height: AppValues.double12,
            )
                .capsulise(
                    radius: 100,
                    color: AppColors.gray900,
                    padding: const EdgeInsets.all(AppValues.double12))
                .padding(const EdgeInsets.only(right: AppValues.double10))
                .onTap(() {
              Get.back();
            }),
            if (titleList?.isNotEmpty == true)
              IntrinsicHeight(
                  child: Row(children: [
                ...?titleList?.mapIndexed(
                  (i, e) {
                    return titleRow(
                        title: e,
                        displayDivider: i != (titleList?.length ?? 0) - 1);
                  },
                )
              ]).capsulise(
                      radius: 100,
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppValues.double10,
                          horizontal: AppValues.double15))),
          ],
        )),
        Row(
          children: [
            const ImageAssetView(
              fileName: AppAssets.addIcon,
              width: AppValues.double12,
            ).capsulise(
                radius: 100,
                color: AppColors.white,
                padding: const EdgeInsets.all(AppValues.double8)),
            Text(
              "Generate new question".toUpperCase(),
              style: MyTextStyle.xxs.bold.c(AppColors.white),
            ).padding(const EdgeInsets.only(
                left: AppValues.double10, right: AppValues.double5))
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
