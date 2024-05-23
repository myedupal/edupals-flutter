import 'package:edupals/core/extensions/view_extensions.dart';
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
          Text(
            "Today's Challenge",
            style: MyTextStyle.l.bold,
          ).padding(const EdgeInsets.all(AppValues.double10)),
          DailyChallengeList(
            challengeList: controller.challengeList?.toList(),
            shrinkWrap: true,
          ),
        ],
      )));

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExploreController());
    return Column(
      children: [challengeList(context)],
    );
  }
}
