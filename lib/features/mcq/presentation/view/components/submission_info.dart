import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:flutter/widgets.dart';

class SubmissionInfo extends StatelessWidget {
  const SubmissionInfo({super.key, this.submission});

  final ChallengeSubmission? submission;

  Widget displayRow({required String icon, String? title}) {
    return Row(
      children: [
        ImageAssetView(
          fileName: icon,
          width: AppValues.double20,
          height: AppValues.double20,
        ),
        Text(
          "$title",
          style: MyTextStyle.xs.bold,
        ).padding(const EdgeInsets.only(left: AppValues.double5))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displayRow(
            icon: AppAssets.blueCircle,
            title: submission?.getParsedTime ?? "0s"),
        displayRow(icon: AppAssets.darkOrangeCrown, title: "30/40").padding(
            const EdgeInsets.symmetric(horizontal: AppValues.double10)),
        displayRow(icon: AppAssets.wrong, title: "3 to improve"),
      ],
    )
        .padding(const EdgeInsets.symmetric(horizontal: AppValues.double5))
        .capsulise(
            radius: 100,
            color: AppColors.white,
            padding: const EdgeInsets.all(AppValues.double10));
  }
}
