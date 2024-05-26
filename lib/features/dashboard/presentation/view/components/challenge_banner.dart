import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeBanner extends StatelessWidget {
  const ChallengeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetList = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppValues.double20,
          ),
          Text(
            "Test yourself with edupals daily challenge",
            style: MyTextStyle.xxxl.bold.c(AppColors.white),
          ),
          Row(
            children: [
              Text(
                "Challenge is out now!",
                style: MyTextStyle.xs.c(AppColors.white),
              ),
              // Text(
              //   "+10 exp",
              //   style: MyTextStyle.xs.c(AppColors.white),
              // ).padding(const EdgeInsets.only(left: AppValues.double20))
            ],
          ),
          SizedBox(
            height: context.isPhonePortrait
                ? AppValues.double40
                : AppValues.double20,
          ),
        ],
      ),
      Text(
        "Start your challenge",
        style: MyTextStyle.xs.bold.c(AppColors.gray900),
      )
          .capsulise(
              radius: 100,
              color: AppColors.white,
              width: context.isPhonePortrait ? double.infinity : null,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.double20, vertical: AppValues.double12))
          .onTap(() {
        Get.toNamed(Routes.dailyChallenge);
      }).padding(EdgeInsets.only(
              bottom: context.isPhonePortrait
                  ? AppValues.double20
                  : AppValues.double0))
    ];
    return widgetList
        .rowToColumn(isActive: context.isPhonePortrait)
        .imageBackground();
  }
}
