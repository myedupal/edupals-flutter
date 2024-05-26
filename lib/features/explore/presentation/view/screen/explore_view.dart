import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/shimmer.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/view/components/daily_challenge_list.dart';
import 'package:edupals/features/explore/presentation/controller/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  Widget get challengeBody {
    return Obx(() {
      switch (controller.viewState) {
        case ViewState.success:
          return DailyChallengeList(
            physics: const NeverScrollableScrollPhysics(),
            challengeList: controller.challengeList?.toList(),
            shrinkWrap: true,
          );
        case ViewState.noData:
          return Container(
            width: double.infinity,
            height: AppValues.double100,
            alignment: Alignment.center,
            child: Text(
              "There is no challenge for you today.",
              style: MyTextStyle.s.medium,
              textAlign: TextAlign.center,
            ),
          ).capsulise(radius: 10, color: AppColors.gray100);
        default:
          return Shimmer.rounded(
            height: AppValues.double150,
            width: Get.width * 0.9,
          );
      }
    });
  }

  Widget challengeList(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ImageAssetView(
                fileName: AppAssets.orangeCrown,
                width: AppValues.double40,
                height: AppValues.double40,
              ).padding(const EdgeInsets.only(right: AppValues.double10)),
              Text(
                "Today's Challenge",
                style: MyTextStyle.l.bold,
              )
            ],
          ).padding(const EdgeInsets.fromLTRB(AppValues.double10,
              AppValues.double5, AppValues.double10, AppValues.double10)),
          challengeBody
        ],
      );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExploreController());
    return ListView(
      children: [challengeList(context)],
    );
  }
}
