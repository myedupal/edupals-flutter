import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/base_snackbar.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/enum/view_state.dart';
import 'package:edupals/core/routes/routing.dart';
import 'package:edupals/features/challenge/domain/model/challenge_argument.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:edupals/features/challenge/domain/model/submission_answer.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_repository.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_submission_repository.dart';
import 'package:edupals/features/challenge/domain/repository/submission_answer_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:get/get.dart';

class ChallengeDetailsController extends BaseController {
  final ChallengeRepository challengeRepo = Get.find();
  final UserQuestionsRepository questionsRepo = Get.find();
  final SubmissionAnswerRepository submissionAnswerRepo = Get.find();
  final ChallengeSubmissionRepository challengeSubmissionRepo = Get.find();
  final ChallengeArgument routeArgument = Get.arguments;
  RxList<Question>? questionList = <Question>[].obs;
  RxList<SubmissionAnswersAttribute>? answeredList =
      <SubmissionAnswersAttribute>[].obs;
  Rx<ChallengeSubmission?> currentChallengeSubmission =
      Rx<ChallengeSubmission?>(null);
  RxInt currentIndex = 0.obs;
  Rx<String>? currentSelectedAnswer = "".obs;
  RxList<SubmissionAnswer?> submissionAnswerList = <SubmissionAnswer>[].obs;
  Rx<String> challengeTitle = "".obs;
  Rx<ViewState> submissionViewState = ViewState.success.obs;

  @override
  void onInit() {
    challengeTitle.value = routeArgument.pageTitle ?? "";
    if (routeArgument.challengeId?.isEmpty == false) {
      getChallenge(id: routeArgument.challengeId ?? "");
    }
    if (routeArgument.questionQueryParams != null) {
      getQuestions(queryParams: routeArgument.questionQueryParams);
    }
    super.onInit();
  }

  double get getProgress {
    return currentIndex / ((questionList?.length ?? 0) - 1);
  }

  Question? get currentQuestion => questionList?[currentIndex.value];

  SubmissionAnswer? get currentSubmissionAnswer =>
      submissionAnswerList.firstWhereOrNull(
          (element) => element?.questionId == currentQuestion?.id);

  bool get isLastQuestion =>
      currentIndex.value == (questionList?.length ?? 0) - 1;

  bool get isChallengeFinish =>
      submissionAnswerList.length == questionList?.length;

  bool get isSubmitted =>
      currentSubmissionAnswer != null &&
      currentSelectedAnswer?.value == currentSubmissionAnswer?.answer;

  bool isCorrect({required String answer}) =>
      currentChallengeSubmission.value?.status != "pending" &&
      currentSubmissionAnswer?.question?.answers?.first.text == answer;

  bool isWrong({required String answer}) =>
      currentChallengeSubmission.value?.status != "pending" &&
      (answer == currentSubmissionAnswer?.answer) &&
      currentSubmissionAnswer?.isCorrect == false;

  Future<void> onSubmitAnswer() async {
    if (currentSubmissionAnswer == null) {
      createSubmissionAnswer();
    } else {
      updateSubmissionAnswer();
    }
  }

  Future<void> finishChallenge() async {
    setSubmissionLoading();
    (currentChallengeSubmission.value?.status == "pending")
        ? await challengeSubmissionRepo.submitChallengeSubmission(
            id: currentChallengeSubmission.value?.id ?? "",
            onSuccess: (value) {
              Get.offAndToNamed(Routes.challengeComplete, arguments: value)
                  ?.then((value) {
                currentIndex.value = 0;
                presetAnswer();
              });
              currentChallengeSubmission.value = value;
              submissionAnswerList.value = value?.submissionAnswers ?? [];
              presetAnswer();
              setSubmissionSuccess();
            },
            onError: (error) {
              setSubmissionSuccess();
              BaseSnackBar.show(message: "Error: ${error.message}");
            })
        : Get.back();
  }

  Future<void> createSubmissionAnswer() async {
    setSubmissionLoading();
    await submissionAnswerRepo.createSubmissionAnswer(
        submissionAnswer: SubmissionAnswer(
            questionId: currentQuestion?.id,
            challengeSubmissionId: currentChallengeSubmission.value?.id,
            answer: currentSelectedAnswer?.value),
        onSuccess: (value) {
          submissionAnswerList.add(value);
          setSubmissionSuccess();
          nextQuestion();
        },
        onError: (error) {
          setSubmissionSuccess();
          BaseSnackBar.show(message: "Error: ${error.message}");
        });
  }

  Future<void> updateSubmissionAnswer() async {
    setSubmissionLoading();
    await submissionAnswerRepo.updateSubmissionAnswer(
        id: currentSubmissionAnswer?.id ?? "",
        submissionAnswer: SubmissionAnswer(
            questionId: currentQuestion?.id,
            answer: currentSelectedAnswer?.value),
        onSuccess: (value) {
          final submissionIndex = submissionAnswerList
              .indexWhere((element) => element?.id == value?.id);
          submissionAnswerList[submissionIndex] = value;
          setSubmissionSuccess();
          nextQuestion();
        },
        onError: (error) {
          setSubmissionSuccess();
        });
  }

  Future<void> getChallenge({required String id}) async {
    setLoading();
    await challengeRepo.getChallenge(
        id: id,
        onSuccess: (value) {
          value?.questions?.isEmpty == true ? setNoData() : setSuccess();
          questionList?.value = value?.questions ?? [];
          getChallengeSubmissions(challengeId: id);
        },
        onError: (error) {});
  }

  Future<void> getQuestions({QueryParams? queryParams}) async {
    setLoading();
    QueryParams? updatedQueryParams = queryParams;
    updatedQueryParams?.sortBy = "number";
    updatedQueryParams?.sortOrder = "asc";
    updatedQueryParams?.questionType = "mcq";
    await questionsRepo.getQuestions(
        queryParams: queryParams,
        onSuccess: (value) {
          if (value.data?.isEmpty == true) {
            setNoData();
          } else {
            setSuccess();
            questionList?.value = value.data ?? [];
            createChallengeSubmission();
          }
        },
        onError: (error) {});
  }

  Future<void> getChallengeSubmissions({required String challengeId}) async {
    setLoading();
    await challengeSubmissionRepo.getChallengeSubmissions(
        queryParams: QueryParams(challengeId: challengeId),
        onSuccess: (value) {
          setSuccess();
          if (value?.isNotEmpty == true) {
            currentChallengeSubmission.value = value?.first;
            getChallengeSubmission();
          } else {
            createChallengeSubmission(challengeId: challengeId);
          }
        },
        onError: (error) {});
  }

  Future<void> getChallengeSubmission() async {
    await challengeSubmissionRepo.getChallengeSubmission(
        id: currentChallengeSubmission.value?.id,
        onSuccess: (value) {
          currentChallengeSubmission.value = value;
          submissionAnswerList.value = value?.submissionAnswers ?? [];
          presetAnswer();
        },
        onError: (error) {});
  }

  Future<void> createChallengeSubmission({String? challengeId}) async {
    setLoading();
    await challengeSubmissionRepo.createChallengeSubmission(
        challengeSubmission: ChallengeSubmission(
            challengeId: challengeId,
            title: challengeId == null
                ? "${routeArgument.subjectTitle}|Year ${routeArgument.questionQueryParams?.year?.first}"
                : currentChallengeSubmission.value?.title),
        onSuccess: (value) {
          setSuccess();
          currentChallengeSubmission.value = value;
        },
        onError: (error) {
          setSuccess();
          BaseSnackBar.show(message: "Error: ${error.message}");
        });
  }

  void onSelectAnswer({required String answer}) {
    currentSelectedAnswer?.value = answer;
    onSubmitAnswer();
  }

  void presetAnswer() {
    if (currentSubmissionAnswer != null) {
      currentSelectedAnswer?.value = currentSubmissionAnswer?.answer ?? "";
    } else {
      currentSelectedAnswer?.value = "";
    }
  }

  void nextQuestion() {
    currentIndex.value < ((questionList?.length ?? 0) - 1)
        ? currentIndex += 1
        : null;
    presetAnswer();
  }

  void onBack() {
    currentIndex.value > 0 ? currentIndex -= 1 : Get.back();
    presetAnswer();
  }

  void setSubmissionLoading() {
    submissionViewState.value = ViewState.loading;
  }

  void setSubmissionSuccess() {
    submissionViewState.value = ViewState.success;
  }

  bool get isSubmissionLoading {
    return submissionViewState.value == ViewState.loading;
  }
}
