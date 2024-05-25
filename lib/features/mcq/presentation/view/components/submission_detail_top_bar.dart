import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/title_divider.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/mcq/presentation/controller/submission_details_controller.dart';
import 'package:edupals/features/mcq/presentation/view/components/submission_info.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SubmissionDetailTopBar extends GetView<SubmissionDetailsController> {
  const SubmissionDetailTopBar({super.key});

  Widget get titleDisplay => Row(
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
          Expanded(
              child: Obx(() => SizedBox(
                    height: AppValues.double50,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              ...controller.getTitleList
                                  .map((e) => TitleDivider(
                                        title: e,
                                        displayDivider:
                                            e != controller.getTitleList.last,
                                      ))
                            ],
                          ),
                        ).topBarWidgetCapsule(color: AppColors.white)
                      ],
                    ),
                  ))),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (context.isPhone) titleDisplay,
        Row(
          children: [
            if (!context.isPhone) Expanded(child: titleDisplay),
            Obx(() => Expanded(
                flex: context.isPhone ? 1 : 0,
                child: SubmissionInfo(
                    submission: controller.currentSubmission.value)))
          ],
        ).capsulise(
            radius: 100,
            color: AppColors.gray100,
            padding: const EdgeInsets.all(AppValues.double10))
      ],
    );
  }
}
