import 'package:collection/collection.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/title_divider.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/presentation/controller/questions_list_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_filter_segment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsListTopBar extends GetView<QuestionsListController> {
  const QuestionsListTopBar({super.key, this.titleList});

  final List<String>? titleList;

  void displaySearch() {
    BaseDialog.customise(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Search Question",
          style: MyTextStyle.l.bold,
        ),
        QuestionFilterSegment(
          ableSelectRevision: false,
          controllerTag: "question-bank",
          emitData: (value) {
            controller.onSetArgument(value: value);
            Get.back();
          },
        )
      ],
    ));
  }

  Widget get generateQuestion => Row(
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
      ).onTap(() {
        displaySearch();
      });

  Widget get timer => Obx(() => Row(
        children: [
          if (controller.formattedTime.value != "00:00:00")
            const ImageAssetView(
              fileName: AppAssets.history,
              color: AppColors.white,
              width: AppValues.double15,
            ).padding(const EdgeInsets.only(right: AppValues.double5)),
          Text(
                  controller.formattedTime.value != "00:00:00"
                      ? "${controller.formattedTime}"
                      : "Start exam mode".toUpperCase(),
                  style: MyTextStyle.xxs.bold.c(AppColors.white))
              .repaintBoundary(),
        ],
      ).onTap(() {
        if (controller.currentActivity.value != null) {
          controller.stopwatch.isRunning
              ? controller.stopStopwatch()
              : controller.startStopwatch();
        }
      }));

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
            if (titleList?.isNotEmpty == true && !context.isPhone)
              IntrinsicHeight(
                  child: Row(children: [
                ...?titleList?.mapIndexed(
                  (i, e) {
                    return TitleDivider(
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
        if (!context.isPhone)
          (controller.isYearly ? timer : generateQuestion).topBarWidgetCapsule()
      ],
    ).capsulise(
        radius: 100,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double10));
  }
}
