import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsListController extends BaseController {
  final UserQuestionsRepository questionsRepo = Get.find();
  final QuestionBankArgument argument = Get.arguments;
  final RxList<Question>? questionsList = <Question>[].obs;
  final RxList<Topic?>? topicList = <Topic>[].obs;
  Rx<Question?> selectedQuestion = Question().obs;

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
        queryParams: argument.queryParams,
        onSuccess: (value) {
          debugPrint("Questions data ${value.pages} ${value.counts}");
          questionsList?.value = value.data ?? [];
          if (questionsList?.isNotEmpty == true) {
            for (int i = 0; i < (questionsList?.length ?? 0); i++) {
              final topic = topicList?.firstWhereOrNull(
                  (element) => element?.id == value.data?[i].topics?[0].id);
              if (topic == null) {
                topicList?.add(value.data?[i].topics?[0]);
              }
            }
            selectedQuestion.value = questionsList?.first;
            setSuccess();
          } else {
            setNoData();
          }
          debugPrint("${topicList?.length ?? 0}");
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
