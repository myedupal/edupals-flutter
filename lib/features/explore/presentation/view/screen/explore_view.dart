import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/view/components/daily_challenge_list.dart';
import 'package:edupals/features/explore/presentation/controller/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  Widget challengeList(BuildContext context) => Obx(() => Expanded(
          child: Column(
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
          DailyChallengeList(
            physics: const NeverScrollableScrollPhysics(),
            challengeList: controller.challengeList?.toList(),
            shrinkWrap: true,
          ),
        ],
      )));

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExploreController());
    return Column(
      children: [
        Expanded(
            child: ListView(
          children: [challengeList(context)],
        ))
      ],
    );
  }
}
