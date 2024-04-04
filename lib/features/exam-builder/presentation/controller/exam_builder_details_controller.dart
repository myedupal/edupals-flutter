import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExamBuilderDetailsController extends BaseController {
  // Controller and repository DI
  final UserQuestionsRepository questionsRepo = Get.find();
  // General State
  final QuestionBankArgument argument = Get.arguments;
  QueryParams? questionListParams;
  RxList<Question> questionsList = <Question>[].obs;
  RxList<Topic?>? topicList = <Topic?>[].obs;
  Rx<Question?> selectedQuestion = Question().obs;
  RxList<Question?> selectedQuestions = <Question?>[].obs;
  RxInt questionTotalPage = 1.obs;
  RxString? examName = "".obs;
  final nameController = TextEditingController();

  @override
  void onInit() {
    if (argument.queryParams != null) {
      questionListParams = argument.queryParams;
      getQuestions();
    }
    super.onInit();
  }

  void submitName() {
    examName?.value = nameController.text;
  }

  void onSearchQuestions({QuestionBankArgument? value}) {
    questionListParams = value?.queryParams;
    getQuestions();
  }

  void onSetExamName({String? name}) {
    examName?.value = name ?? "";
  }

  void onSelectQuestion({required Question question}) {
    selectedQuestion.value = question;
  }

  void onAddQuestion({required Question question}) {
    if (isQuestionAdded(question.id)) {
      selectedQuestions.removeWhere((element) => element?.id == question.id);
    } else {
      selectedQuestions.add(question);
    }
  }

  bool isQuestionAdded(String? id) {
    return selectedQuestions.firstWhereOrNull((element) => element?.id == id) !=
        null;
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
              : questionsList.value = value.data ?? [];

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

  void processData() {
    topicList?.value = [];
    for (int i = 0; i < (questionsList.length); i++) {
      if (questionsList[i].topics?.isEmpty == true) {
        questionsList[i].topics = [Topic(id: "No Topic", name: "No Topic")];
      }
      final topic = topicList?.firstWhereOrNull((element) =>
          element?.id == (questionsList[i].topics?.first.id ?? ""));
      if (topic == null) {
        topicList?.add(questionsList[i].topics?.first);
      }
    }
    selectedQuestion.value = questionsList.first;
  }
}