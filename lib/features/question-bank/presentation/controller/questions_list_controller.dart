import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsListController extends BaseController {
  final UserQuestionsRepository questionsRepo = Get.find();
  final RxList<Question>? questionsList = <Question>[].obs;
  final RxList<Topic?>? topicList = <Topic>[].obs;
  Rx<Question?> selectedQuestion = Question().obs;

  // Get Subject List
  // Get paper list in subject list
  // Get topics

  @override
  void onInit() {
    super.onInit();
    getQuestions();
  }

  void onSelectQuestion({required Question question}) {
    selectedQuestion.value = question;
  }

  void questionAction(String action) {
    final filteredQuestionIndex = questionsList
        ?.indexWhere((element) => element.id == selectedQuestion.value?.id);
    switch (action) {
      case "back":
        if (filteredQuestionIndex != 0) {
          selectedQuestion.value =
              questionsList?[(filteredQuestionIndex ?? 0) - 1];
        }
      case "next":
        if (filteredQuestionIndex != (questionsList?.length ?? 0) - 1) {
          selectedQuestion.value =
              questionsList?[(filteredQuestionIndex ?? 0) + 1];
        }
    }
  }

  Future<void> getQuestions() async {
    setLoading();
    await questionsRepo.getQuestions(
        queryParams: QueryParams(
          // examId: [
          //   "f9f2a4e9-485c-4c6b-b48d-62012438237a",
          //   "a8f7cbb0-07a0-4622-836e-2d00e7f1fecb"
          // ],
          topicId: [
            "9e23d733-6e23-45cf-95cf-a2c9ad1a391a",
            "c94367ad-acd7-4285-8898-f1f08d854889"
          ],
          // subjectId: "6d0ca8ec-962e-4007-8d09-73d2530fa418",
          items: 100,
        ),
        onSuccess: (value) {
          questionsList?.value = value ?? [];
          // questionsList?.sort(compareQuestions);
          for (int i = 0; i < (questionsList?.length ?? 0); i++) {
            final topic = topicList?.firstWhereOrNull(
                (element) => element?.id == value?[i].topics?[0].id);
            if (topic == null) {
              topicList?.add(value?[i].topics?[0]);
            }
          }
          selectedQuestion.value = questionsList?.first;
          debugPrint("${topicList?.length ?? 0}");
          setSuccess();
        },
        onError: (error) {});
  }

  int compareQuestions(Question a, Question b) {
    int zoneComparison = a.exam?.zone?.compareTo(b.exam?.zone ?? "") ?? 0;
    if (zoneComparison != 0) {
      return zoneComparison;
    }

    int topicComparison =
        a.topics?[0].name?.compareTo(b.topics?[0].name ?? "") ?? 0;
    if (topicComparison != 0) {
      return topicComparison;
    }

    return a.number?.compareTo(b.number ?? "") ?? 0;
  }
}
