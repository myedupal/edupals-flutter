import 'package:edupals/core/components/base_accordion.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/question-bank/presentation/controller/questions_list_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/question_action_list.dart';
import 'package:edupals/features/question-bank/presentation/view/components/questions_list_column.dart';
import 'package:edupals/features/question-bank/presentation/view/components/questions_list_top_bar.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsListView extends GetView<QuestionsListController> {
  const QuestionsListView({super.key});

  Widget get actionList => QuestionActionList(
        action: (value) {
          controller.questionAction(value);
        },
      );

  Widget get questionDetails => Obx(() {
        final selectedQuestion = controller.selectedQuestion.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${selectedQuestion?.number} ${selectedQuestion?.exam?.year} ${selectedQuestion?.exam?.season} ${selectedQuestion?.exam?.zone}",
              style: MyTextStyle.xxl.bold,
            ),
            Expanded(
                child: ListView(shrinkWrap: true, children: [
              Column(
                children: [
                  ...?selectedQuestion?.questionImages?.map((e) =>
                      ImageAssetView(fileName: e.image?.url ?? "").padding(
                          const EdgeInsets.only(bottom: AppValues.double50)))
                ],
              ).padding(
                  const EdgeInsets.symmetric(vertical: AppValues.double20))
            ]))
          ],
        ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double40));
      });

  Widget get chapterList => Column(
        children: [
          const TrendingColumn(
            percentage: 50,
          ).padding(const EdgeInsets.only(bottom: AppValues.double20)),
          Expanded(
              child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                Obx(() {
                  return Column(
                    children: [
                      ...?controller.topicList?.map(
                        (element) {
                          final filteredQuestions = controller.questionsList
                              ?.where((question) =>
                                  question.topics?.first.id == element?.id);
                          return BaseAccordion(
                            title: element?.name ?? "",
                            child: Column(children: [
                              ...?filteredQuestions?.map((e) =>
                                  QuestionsListColumn(
                                          question: e,
                                          isActive: controller
                                                  .selectedQuestion.value?.id ==
                                              e.id)
                                      .onTap(() {
                                    controller.onSelectQuestion(question: e);
                                  }))
                            ]),
                          );
                        },
                      )
                    ],
                  );
                }),
              ]))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuestionsListTopBar(),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: chapterList),
            Expanded(flex: 8, child: questionDetails),
            actionList
          ],
        ).padding(const EdgeInsets.symmetric(
                horizontal: AppValues.double10, vertical: AppValues.double25)))
      ],
    ).padding(const EdgeInsets.all(AppValues.double10)).scaffoldWrapper();
  }
}
