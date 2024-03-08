import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/view/components/answer_selection_row.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_progress_bar.dart';
import 'package:flutter/material.dart';

class DailyChallengeView extends StatelessWidget {
  const DailyChallengeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage(AppAssets.layoutBg),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Your Daily Challenge",
            style: MyTextStyle.xl1.bold,
          ).padding(const EdgeInsets.symmetric(vertical: AppValues.double30)),
          const ChallengeProgressBar(),
          Expanded(
              child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  const ImageAssetView(
                    fileName: AppAssets.mockQuestion,
                  ).padding(
                      const EdgeInsets.symmetric(vertical: AppValues.double30)),
                  for (int i = 0; i < 5; i++)
                    AnswerSelectionRow(
                      isActive: i == 0,
                    )
                ],
              )
            ],
          ))
        ],
      )
          .padding(const EdgeInsets.only(
              top: AppValues.double30,
              left: AppValues.double30,
              right: AppValues.double30))
          .scaffoldWrapper(backgroundColor: Colors.transparent)
          .constraintsWrapper(width: 800, color: Colors.transparent),
    );
  }
}
