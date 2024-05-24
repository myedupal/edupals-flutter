import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:edupals/features/challenge/domain/model/submission_answer.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_submission_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:get/get.dart';

class SubmissionDetailsController extends BaseController {
  final ChallengeSubmissionRepository challengeSubmissionRepo = Get.find();
  Rx<ChallengeSubmission?> currentSubmission = Rx<ChallengeSubmission?>(null);
  String? submissionId = Get.parameters["id"];
  QueryParams? submissionListParams =
      QueryParams(page: 1, items: 100, status: "submitted", mcq: true);
  Rx<Question?> selectedQuestion = Rx<Question?>(null);
  Rx<int> currentIndex = 0.obs;

  @override
  void onInit() {
    getSubmission();
    super.onInit();
  }

  List<SubmissionAnswer>? get submissionAnswers =>
      currentSubmission.value?.submissionAnswers;

  bool isCorrect({required String answer}) =>
      selectedQuestion.value?.answers?.first.text == answer;

  bool isWrong({required String answer}) =>
      (answer ==
          currentSubmission
              .value?.submissionAnswers?[currentIndex.value].answer) &&
      currentSubmission
              .value?.submissionAnswers?[currentIndex.value].isCorrect ==
          false;

  void onSelectQuestion({required int index}) {
    selectedQuestion.value = submissionAnswers?[index].question;
    currentIndex.value = index;
  }

  void onBackQuestion() {
    if (currentIndex > 0) {
      onSelectQuestion(index: currentIndex.value -= 1);
    }
  }

  void onNextQuestion() {
    if (currentIndex < (submissionAnswers?.length ?? 0) - 1) {
      onSelectQuestion(index: currentIndex.value += 1);
    }
  }

  Future<void> getSubmission() async {
    setLoading();
    await challengeSubmissionRepo.getChallengeSubmission(
        id: submissionId ?? "",
        onSuccess: (value) {
          setSuccess();
          currentSubmission.value = value;
          currentSubmission.value?.submissionAnswers?.sort((a, b) =>
              (a.question?.number ?? 0).compareTo(b.question?.number ?? 0));
          selectedQuestion.value =
              currentSubmission.value?.submissionAnswers?.first.question;
        },
        onError: (error) {});
  }
}
