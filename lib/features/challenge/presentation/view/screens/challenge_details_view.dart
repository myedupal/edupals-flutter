import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/controller/challenge_details_controller.dart';
import 'package:edupals/features/challenge/presentation/view/components/answer_selection_row.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_progress_bar.dart';
import 'package:edupals/features/challenge/presentation/view/components/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeDetailsView extends GetView<ChallengeDetailsController> {
  const ChallengeDetailsView({super.key});

  Widget get challengeBody => Expanded(
          child: Column(
        children: [
          Text(
            "Your Daily Challenge",
            style: MyTextStyle.xl1.bold,
          ).padding(const EdgeInsets.only(
              bottom: AppValues.double20, top: AppValues.double20)),
          Obx(
            () => ChallengeProgressBar(
              progress: controller.getProgress,
              onBack: () => controller.onBack(),
            ),
          ),
          Obx(() => controller.questionList?.isNotEmpty == true
              ? Expanded(
                  child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        ImageAssetView(
                          fileName: controller.currentQuestion?.questionImages
                                  ?.first.image?.url ??
                              "",
                        )
                            .padding(const EdgeInsets.symmetric(
                                vertical: AppValues.double30))
                            .onTap(() {
                          BaseDialog.customise(
                              isBase: true,
                              child: ImageViewer(
                                imageUrl: controller.currentQuestion
                                    ?.questionImages?.first.image?.url,
                              ));
                        }),
                      ],
                    ),
                  ],
                ))
              : Container()),
          Row(
            children: [
              ...["A", "B", "C", "D"].map((e) => Expanded(
                      child: AnswerSelectionRow(
                    title: e,
                    isCorrect: false,
                    isWrong: false,
                    isActive: controller.currentSelectedAnswer?.value == e,
                  )
                          .padding(
                              const EdgeInsets.only(right: AppValues.double30))
                          .onTap(() {
                    controller.onSelectAnswer(answer: e);
                  })))
            ],
          ).padding(const EdgeInsets.only(
              top: AppValues.double10, bottom: AppValues.double30)),
        ],
      ));

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
          Obx(() => controller.questionList?.isEmpty == true
              ? const NoDataView(message: "There is no questions for you ...")
              : challengeBody)
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
