import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/routing.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeCompleteView extends StatelessWidget {
  ChallengeCompleteView({super.key});

  final ChallengeSubmission? challengeSubmission = Get.arguments;

  String? get getTitle {
    return challengeSubmission?.challenge != null
        ? "challenge for ${challengeSubmission?.challenge?.title}"
        : "MCQ for ${challengeSubmission?.title?.split("|")[1]}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
              image: AssetImage(AppAssets.staticConfetti),
              alignment: Alignment.topCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageAssetView(
            fileName: AppAssets.appIcon,
            width: context.isPhone ? AppValues.double40 : AppValues.double60,
            height: context.isPhone ? AppValues.double40 : AppValues.double60,
          ).capsulise(
              radius: 100,
              padding: const EdgeInsets.all(AppValues.double30),
              color: AppColors.gray100),
          const SizedBox(
            height: AppValues.double50,
          ),
          Text(
            "Hurray! You've completed $getTitle",
            style:
                context.isPhone ? MyTextStyle.xxxl.bold : MyTextStyle.xl2.bold,
            textAlign: TextAlign.center,
          ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double20)),
          const SizedBox(
            height: AppValues.double50,
          ),
          BaseButton(
              text: "Review Questions",
              onClick: () {
                Get.back();
              }),
          Text(
            "Back to dashboard",
            style: MyTextStyle.s.bold.c(AppColors.accent500),
          ).padding(const EdgeInsets.only(top: AppValues.double20)).onTap(() {
            Get.offAllNamed(Routes.home);
          }),
          const SizedBox(
            height: AppValues.double100,
          ),
        ],
      )
          .constraintsWrapper(width: 700, color: Colors.transparent)
          .scaffoldWrapper(backgroundColor: Colors.transparent),
    );
  }
}
