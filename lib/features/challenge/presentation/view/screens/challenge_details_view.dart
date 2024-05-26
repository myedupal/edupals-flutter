import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/components/loading_view.dart';
import 'package:edupals/core/components/no_data_view.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/presentation/controller/challenge_details_controller.dart';
import 'package:edupals/features/challenge/presentation/view/components/answer_selection_row.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_image_display.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_progress_bar.dart';
import 'package:edupals/features/challenge/presentation/view/components/challenge_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeDetailsView extends GetView<ChallengeDetailsController> {
  const ChallengeDetailsView({super.key});

  void displayWarning() {
    if (controller.currentChallengeSubmission.value?.status == "pending") {
      BaseDialog.showError(
        title: "Are you sure to quit?",
        subtitle: "You will lose your current progress",
        buttonText: "Quit now",
        action: () {
          Get.back();
          Get.back();
        },
      );
    } else {
      Get.back();
    }
  }

  Widget get challengeBody => Obx(() => Column(
        children: [
          const ChallengeTitle(),
          const ChallengeProgressBar(),
          controller.questionList?.isNotEmpty == true
              ? Expanded(
                  child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ...?controller.currentQuestion?.questionImages?.map(
                      (e) {
                        return ChallengeImageDisplay(
                          imageUrl: e.image?.url,
                        );
                      },
                    )
                  ],
                ))
              : Container(),
          Text(
            "* Tap image to zoom in",
            style: MyTextStyle.xxs.c(AppColors.gray600),
          ),
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
                                "pending" &&
                            !controller.isSubmissionLoading) {
                          controller.onSelectAnswer(answer: e);
                        }
                      })))
                ],
              ).padding(EdgeInsets.only(
                  top: AppValues.double10,
                  bottom: controller.isChallengeFinish
                      ? AppValues.double0
                      : AppValues.double30)),
              if (controller.isChallengeFinish)
                BaseButton(
                  isLoading: controller.isSubmissionLoading,
                  text: "Finish",
                  onClick: () {
                    controller.finishChallenge();
                  },
                  fullWidth: true,
                ).padding(const EdgeInsets.only(bottom: AppValues.double30))
            ],
          )
        ],
      ));

  Widget get pageBody {
    return Obx(() {
      switch (controller.viewState) {
        case ViewState.loading:
          return const LoadingView();
        case ViewState.noData:
          return const NoDataView(message: "There is no question for you...");
        default:
          return Expanded(
            child: challengeBody.padding(const EdgeInsets.only(
                top: AppValues.double30,
                left: AppValues.double15,
                right: AppValues.double15)),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [pageBody],
        )
            .scaffoldWrapper(backgroundColor: Colors.transparent)
            .constraintsWrapper(width: 700, color: Colors.transparent)
            .addBackgroundImage(),
        Positioned(
            right: AppValues.double20,
            top: AppValues.double15,
            child: const ImageAssetView(
              fileName: AppAssets.cross,
              width: AppValues.double15,
              height: AppValues.double15,
            )
                .capsulise(
                    radius: 100,
                    color: AppColors.gray100,
                    padding: const EdgeInsets.all(AppValues.double15))
                .onTap(() {
              displayWarning();
            }))
      ],
    );
  }
}
