import 'package:edupals/core/components/base_accordion.dart';
import 'package:edupals/features/exam-builder/presentation/controller/exam_builder_details_controller.dart';
import 'package:edupals/features/question-bank/presentation/view/components/questions_list_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamChapterDisplayList extends GetView<ExamBuilderDetailsController> {
  const ExamChapterDisplayList({super.key});

  void _loadMoreData() {
    if ((controller.questionTotalPage >
        (controller.questionListParams?.page ?? 1))) {
      controller.getQuestions(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Obx(() {
          final topicList = controller.topicList;
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: topicList?.length ?? 0,
              itemBuilder: (context, index) {
                if (index == (topicList?.length ?? 0) - 1) {
                  _loadMoreData();
                }
                final currentTopic = topicList?[index];
                final filteredQuestions = controller.questionsList.where(
                    (question) =>
                        question.topics?.first.id == currentTopic?.id);
                return Obx(() => BaseAccordion(
                      title: currentTopic?.name ?? "",
                      child: Column(children: [
                        ...filteredQuestions.map((e) {
                          return QuestionsListColumn(
                            question: e,
                            isActive:
                                controller.selectedQuestion.value?.id == e.id,
                            ableAdd: true,
                            isAddActive: controller.isQuestionAdded(e.id),
                            onTap: () {
                              controller.onSelectQuestion(question: e);
                            },
                            onAddTap: () {
                              controller.onAddQuestion(question: e);
                            },
                          );
                        })
                      ]),
                    ));
              });
        }))
      ],
    );
  }
}
