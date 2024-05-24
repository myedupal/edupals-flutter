import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:edupals/features/mcq/presentation/view/components/submission_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionColumn extends StatelessWidget {
  const SubmissionColumn({super.key, this.submission});

  final ChallengeSubmission? submission;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              "Challenge",
              style: MyTextStyle.m.bold,
            )),
            Text(
              "View",
              style: MyTextStyle.xxs.bold.c(AppColors.gray900),
            )
                .capsulise(
                    radius: 100,
                    border: true,
                    borderColor: AppColors.gray400,
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        vertical: AppValues.double5,
                        horizontal: AppValues.double15))
                .onTap(() {
              Get.toNamed(
                  "${Routes.submissionDetails}/${submission?.id ?? ""}");
            })
          ],
        ).padding(const EdgeInsets.only(bottom: AppValues.double10)),
        SubmissionInfo(submission: submission)
      ],
    ).capsulise(
        radius: 10,
        color: AppColors.gray100,
        padding: const EdgeInsets.all(AppValues.double15));
  }
}
