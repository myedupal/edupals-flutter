import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class ChallengeBanner extends StatelessWidget {
  const ChallengeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppValues.double20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppAssets.dashboardChallengeBg))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppValues.double20,
              ),
              Text(
                "Test yourself with edupals exam mode",
                style: MyTextStyle.xxxl.bold.c(AppColors.white),
              ),
              Row(
                children: [
                  Text(
                    "10 questions",
                    style: MyTextStyle.xs.c(AppColors.white),
                  ),
                  Text(
                    "+10 exp",
                    style: MyTextStyle.xs.c(AppColors.white),
                  ).padding(const EdgeInsets.only(left: AppValues.double20))
                ],
              ),
              const SizedBox(
                height: AppValues.double20,
              ),
            ],
          ),
          Text(
            "Start your challenge",
            style: MyTextStyle.xs.bold.c(AppColors.accent500),
          ).capsulise(
              radius: 100,
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.double20, vertical: AppValues.double12))
        ],
      ),
    );
  }
}
