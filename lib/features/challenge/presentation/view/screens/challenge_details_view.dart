import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/controller/challenge_details_controller.dart';
import 'package:edupals/features/challenge/presentation/view/components/answer_selection_row.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_image_display.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeDetailsView extends GetView<ChallengeDetailsController> {
  const ChallengeDetailsView({super.key});

  Widget get challengeBody => Obx(() => Column(
        children: [
          Text(
            "${controller.challengeTitle}",
            style: MyTextStyle.xxxl.bold,
          ).padding(const EdgeInsets.only(
              bottom: AppValues.double20, top: AppValues.double20)),
          ChallengeProgressBar(
            progress: controller.getProgress,
            onBack: () => controller.onBack(),
          ),
          controller.questionList?.isNotEmpty == true
              ? Expanded(
                  child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ChallengeImageDisplay(
                      imageUrl: controller
                          .currentQuestion?.questionImages?.first.image?.url,
                    )
                  ],
                ))
              : Container(),
          Column(
            children: [
              Row(
                children: [
                  ...["A", "B", "C", "D"].map((e) => Expanded(
                          child: AnswerSelectionRow(
                        title: e,
                        isCorrect: controller.isCorrect(answer: e),
                        isWrong: controller.isWrong(answer: e),
                        isActive: controller.currentSelectedAnswer?.value == e,
                      )
                              .padding(const EdgeInsets.only(
                                  right: AppValues.double20))
                              .onTap(() {
                        if (controller
                                .currentChallengeSubmission.value?.status ==
                            "pending") {
                          controller.onSelectAnswer(answer: e);
                        }
                      })))
                ],
              ).padding(const EdgeInsets.only(top: AppValues.double10)),
              BaseButton(
                text: controller.isSubmitted
                    ? controller.isLastQuestion
                        ? "Finish"
                        : "Next Question"
                    : "Submit",
                enabled: controller.currentSelectedAnswer?.value.isNotEmpty ==
                        true ||
                    controller.isSubmitted,
                onClick: () {
                  controller.isSubmitted
                      ? controller.isLastQuestion
                          ? controller.finishChallenge()
                          : controller.nextQuestion()
                      : controller.onSubmitAnswer();
                },
                fullWidth: true,
              ).padding(const EdgeInsets.only(bottom: AppValues.double30))
            ],
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.questionList?.isEmpty == true
            ? const NoDataView(message: "There is no questions for you ...")
            : Expanded(child: challengeBody))
      ],
    )
        .padding(const EdgeInsets.only(
            top: AppValues.double30,
            left: AppValues.double30,
            right: AppValues.double30))
        .scaffoldWrapper(backgroundColor: Colors.transparent)
        .constraintsWrapper(width: 800, color: Colors.transparent)
        .addBackgroundImage();
  }
}
