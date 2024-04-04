import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/presentation/controller/questions_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionDisplayList extends GetView<QuestionsListController> {
  const QuestionDisplayList({super.key});

  Widget questionColumnDisplay({Question? question, bool isActive = false}) {
    return Text(
      "Q${question?.number} - ${question?.topics?.first.getChapter}",
      style:
          MyTextStyle.xs.bold.c(isActive ? AppColors.white : AppColors.gray900),
    )
        .capsulise(
            radius: 10,
            color: isActive ? AppColors.accent500 : AppColors.gray100,
            padding: const EdgeInsets.symmetric(
                horizontal: AppValues.double10, vertical: AppValues.double10))
        .padding(const EdgeInsets.only(bottom: AppValues.double15));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.questionsList.length,
        itemBuilder: (context, index) {
          final question = controller.questionsList[index];
          return Obx(() => questionColumnDisplay(
                      question: question,
                      isActive:
                          controller.selectedQuestion.value?.id == question.id)
                  .onTap(() {
                controller.onSelectQuestion(question: question);
              }));
        }));
  }
}
