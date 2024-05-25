import 'package:collection/collection.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/challenge/domain/model/submission_answer.dart';
import 'package:edupals/features/challenge/presentation/view/components/answer_selection_row.dart';
import 'package:edupals/features/mcq/presentation/controller/submission_details_controller.dart';
import 'package:edupals/features/mcq/presentation/view/components/submission_detail_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionDetailsView extends GetView<SubmissionDetailsController> {
  const SubmissionDetailsView({super.key});

  Color getQuestionBackgroundColor(
      SubmissionAnswer submissionAnswer, int index) {
    if (index == controller.currentIndex.value) {
      return AppColors.accent50;
    } else if (submissionAnswer.isCorrect == false) {
      return AppColors.pink50;
    }
    return AppColors.gray100;
  }

  Color getQuestionTextColor(SubmissionAnswer submissionAnswer, int index) {
    if (index == controller.currentIndex.value) {
      return AppColors.accent500;
    } else if (submissionAnswer.isCorrect == false) {
      return AppColors.pink500;
    }
    return AppColors.gray900;
  }

  Widget questionList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: context.isPhone ? 0 : AppValues.double40),
      width: context.isPhone ? null : AppValues.double50,
      height: context.isPhone ? AppValues.double50 : null,
      child: ListView(
        scrollDirection: context.isPhone ? Axis.horizontal : Axis.vertical,
        children: [
          ...?controller.currentSubmission.value?.submissionAnswers?.mapIndexed(
            (i, e) => Text(
              "Q${e.question?.number}",
              style: MyTextStyle.s.bold.c(getQuestionTextColor(e, i)),
              textAlign: TextAlign.center,
            )
                .capsulise(
                    alignment: Alignment.center,
                    width: AppValues.double50,
                    height: AppValues.double50,
                    radius: 100,
                    color: getQuestionBackgroundColor(e, i),
                    padding: const EdgeInsets.all(AppValues.double10))
                .padding(EdgeInsets.only(
                    right: context.isPhone
                        ? AppValues.double10
                        : AppValues.double0,
                    bottom: context.isPhone
                        ? AppValues.double0
                        : AppValues.double10))
                .onTap(() {
              controller.onSelectQuestion(index: i);
            }),
          )
        ],
      ),
    );
  }

  Widget get questionSwitcher {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ImageAssetView(
          fileName: AppAssets.leftChevron,
          height: AppValues.double15,
          color: AppColors.white,
        )
            .capsulise(
                radius: 100,
                color: AppColors.accent500,
                padding: const EdgeInsets.all(AppValues.double10))
            .padding(const EdgeInsets.only(right: AppValues.double10))
            .onTap(() {
          controller.onBackQuestion();
        }),
        Expanded(
            child: Row(
          children: [
            ...["A", "B", "C", "D"].map((e) => Expanded(
                child: AnswerSelectionRow(
                        title: e,
                        isCorrect: false,
                        isWrong: controller.isWrong(answer: e),
                        isActive: controller.isCorrect(answer: e))
                    .padding(const EdgeInsets.only(right: AppValues.double10))))
          ],
        )),
        const ImageAssetView(
          fileName: AppAssets.rightChevron,
          height: AppValues.double15,
          color: AppColors.white,
        )
            .capsulise(
                radius: 100,
                color: AppColors.accent500,
                padding: const EdgeInsets.all(AppValues.double10))
            .onTap(() {
          controller.onNextQuestion();
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SubmissionDetailTopBar(),
        Obx(() {
          return Expanded(
            child: [
              questionList(context),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${controller.selectedQuestion.value?.number ?? 1}",
                    style: MyTextStyle.xl.bold,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Column(
                        children: [
                          ...?controller.selectedQuestion.value?.questionImages
                              ?.map((e) =>
                                  ImageAssetView(fileName: e.image?.url ?? "")
                                      .padding(const EdgeInsets.only(
                                          bottom: AppValues.double50)))
                        ],
                      ).padding(const EdgeInsets.symmetric(
                          vertical: AppValues.double20))
                    ],
                  )),
                  questionSwitcher
                ],
              ).padding(const EdgeInsets.only(top: AppValues.double20)))
            ]
                .rowToColumn(
                    isActive: context.isPhone,
                    rowCrossAlignment: CrossAxisAlignment.start)
                .constraintsWrapper(width: 800)
                .padding(EdgeInsets.all(
                    context.isPhone ? AppValues.double10 : AppValues.double20)),
          );
        })
      ],
    ).padding(const EdgeInsets.all(AppValues.double10)).scaffoldWrapper();
  }
}
