import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/exam-builder/domain/model/user_exam.dart';
import 'package:edupals/features/exam-builder/domain/repository/user_exam_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExamBuilderDetailsController extends BaseController {
  // Controller and repository DI
  final UserQuestionsRepository questionsRepo = Get.find();
  final UserExamRepository userExamRepo = Get.find();
  final QuestionBankArgument argument = Get.arguments;
  // General State
  RxBool ableEdit = true.obs;
  String? currentUserExamId = "";
  Rx<UserExam?> apiUserExam = Rx<UserExam?>(null);
  QueryParams? questionListParams;
  RxList<Question> questionsList = <Question>[].obs;
  RxList<Topic?>? topicList = <Topic?>[].obs;
  Rx<Question?> selectedQuestion = Question().obs;
  RxList<Question?> selectedQuestions = <Question?>[].obs;
  RxInt questionTotalPage = 1.obs;
  RxString? examName = "".obs;
  Rx<UserExam?> currentUserExam = Rx<UserExam?>(null);
  UserExam userExamRequestBody = UserExam();
  final nameController = TextEditingController();

  @override
  void onInit() {
    if (argument.queryParams != null) {
      questionListParams = argument.queryParams;
      getQuestions();
    }
    final String? argumentUserExamId = argument.userExamId;
    if (argumentUserExamId?.isEmpty == false) {
      currentUserExamId = argumentUserExamId;
      ableEdit.value = false;
      getUserExamDetails();
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

  Future<void> getUserExam() async {
    setLoading();
    await userExamRepo.getUserExam(
        id: "",
        onSuccess: (value) {
          currentUserExam.value = value;
          setSuccess();
        },
        onError: (error) {});
  }

  Future<void> createUserExam() async {
    compileSelectedQuestions();
    userExamRequestBody.title = examName?.value;
    userExamRequestBody.subjectId = questionListParams?.subjectId;
    await userExamRepo.createUserExam(
        userExam: userExamRequestBody,
        onSuccess: (value) {
          currentUserExam.value = value;
          showSuccessDialog(message: "You exam created successfully!");
        },
        onError: (error) {});
  }

  void compileSelectedQuestions() {
    userExamRequestBody.userExamQuestionsAttributes = selectedQuestions
        .map((element) => UserExamQuestion(questionId: element?.id ?? ""))
        .toList();
    if (apiUserExam.value != null) {
      for (int i = 0;
          i < (apiUserExam.value?.userExamQuestions?.length ?? 0);
          i++) {
        final apiUserExamQuestion = apiUserExam.value?.userExamQuestions?[i];
        final filteredQuestion = selectedQuestions.firstWhereOrNull(
            (element) => element?.id == apiUserExamQuestion?.question?.id);
        if (filteredQuestion == null) {
          userExamRequestBody.userExamQuestionsAttributes?.add(
              UserExamQuestion(id: apiUserExamQuestion?.id, isDestroy: true));
        } else {
          userExamRequestBody.userExamQuestionsAttributes?.removeWhere(
              (element) =>
                  element.questionId == apiUserExamQuestion?.question?.id);
        }
      }
    }
  }

  void showSuccessDialog({String? message}) {
    BaseDialog.showSuccess(
      message: message,
      action: () {
        Get.back();
        Get.back();
      },
    );
  }

  Future<void> updateUserExam({UserExam? userExam}) async {
    compileSelectedQuestions();
    await userExamRepo.updateUserExam(
        userExam: userExamRequestBody,
        id: apiUserExam.value?.id ?? "",
        onSuccess: (value) {
          currentUserExam.value = value;
          showSuccessDialog(message: "You exam updated successfully!");
        },
        onError: (error) {});
  }

  Future<void> getUserExamDetails() async {
    setLoading();
    await userExamRepo.getUserExam(
        id: currentUserExamId ?? "",
        onSuccess: (value) {
          examName?.value = value?.title ?? "";
          for (int i = 0; i < (value?.userExamQuestions?.length ?? 0); i++) {
            questionsList.add(value!.userExamQuestions![i].question!);
            selectedQuestions.add(value.userExamQuestions![i].question!);
          }
          processData();
          apiUserExam.value = value;
          setSuccess();
        },
        onError: (error) {});
  }
}
