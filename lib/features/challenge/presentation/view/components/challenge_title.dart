import 'package:edupals/core/components/title_divider.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/controller/challenge_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeTitle extends GetView<ChallengeDetailsController> {
  const ChallengeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${controller.mainTitle}",
          style: MyTextStyle.xxxl.bold,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...controller.getSubtitleList.map((e) => TitleDivider(
                    title: e,
                    displayDivider: e != controller.getSubtitleList.last,
                  ))
            ],
          ),
        ).padding(const EdgeInsets.only(top: AppValues.double10))
      ],
    ).padding(const EdgeInsets.only(
        bottom: AppValues.double20, top: AppValues.double20));
  }
}
