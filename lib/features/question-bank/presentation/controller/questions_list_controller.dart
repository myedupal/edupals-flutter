import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/domain/repository.dart/activity_question_repository.dart';
import 'package:edupals/features/history/domain/repository.dart/activity_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:get/get.dart';

class QuestionsListController extends BaseController {
  final UserQuestionsRepository questionsRepo = Get.find();
  final ActivityQuestionRepository activityQuestionRepo = Get.find();
  final ActivityRepository activityRepo = Get.find();
  final QuestionBankArgument argument = Get.arguments;
  QueryParams? questionListParams;
  RxList<Question> questionsList = <Question>[].obs;
  RxList<Topic?>? topicList = <Topic?>[].obs;
  Rx<Question?> selectedQuestion = Question().obs;
  RxInt questionTotalPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    if (argument.queryParams != null) {
      questionListParams = argument.queryParams;
    }
    getQuestions();
  }

  void onSelectQuestion({required Question question}) {
    selectedQuestion.value = question;
  }

  void questionAction(String action) {
    final filteredQuestionIndex = questionsList
        .indexWhere((element) => element.id == selectedQuestion.value?.id);
    switch (action) {
      case "back":
        if (filteredQuestionIndex != 0) {
          selectedQuestion.value = questionsList[(filteredQuestionIndex) - 1];
        }
      case "next":
        if (filteredQuestionIndex != (questionsList.length) - 1) {
          selectedQuestion.value = questionsList[(filteredQuestionIndex) + 1];
        }
    }
  }

  Future<void> getQuestions({bool loadMore = false}) async {
    int page = questionListParams?.page ?? 1;
    if (loadMore) {
      questionListParams?.page = page + 1;
    } else {
      setLoading();
    }
    await questionsRepo.getQuestions(
        queryParams: questionListParams,
        onSuccess: (value) {
          loadMore
              ? questionsList = (questionsList) + (value.data ?? [])
              : {questionsList.value = value.data ?? [], createActivity()};

          questionsList.isNotEmpty == true
              ? {
                  processData(),
                  questionTotalPage.value = int.parse(value.pages ?? "1"),
                  setSuccess()
                }
              : setNoData();
        },
        onError: (error) {});
  }

  Future<void> createActivity() async {
    await activityRepo.createActivity(
        activity: Activity(
          subjectId: questionListParams?.subjectId,
          activityType: argument.revisionType,
          topicIds: questionListParams?.topicId,
          paperIds: [questionListParams?.paperId ?? ""],
          metadata: questionListParams,
        ),
        onSuccess: (value) {},
        onError: (error) {});
  }

  void processData() {
    topicList?.value = [];
    for (int i = 0; i < (questionsList.length); i++) {
      final topic = topicList?.firstWhereOrNull(
          (element) => element?.id == questionsList[i].topics?.first.id);
      if (topic == null) {
        topicList?.add(questionsList[i].topics?.first);
      }
    }
    selectedQuestion.value = questionsList.first;
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
