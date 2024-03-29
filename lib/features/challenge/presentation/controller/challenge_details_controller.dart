import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:edupals/features/challenge/domain/model/submission_answer.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_repository.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_submission_repository.dart';
import 'package:edupals/features/challenge/domain/repository/submission_answer_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:get/get.dart';

class ChallengeDetailsController extends BaseController {
  final ChallengeRepository challengeRepo = Get.find();
  final SubmissionAnswerRepository submissionAnswerRepo = Get.find();
  final ChallengeSubmissionRepository challengeSubmissionRepo = Get.find();
  final String challengeId = Get.parameters["id"] ?? '';
  RxList<Question>? questionList = <Question>[].obs;
  RxList<SubmissionAnswersAttribute>? answeredList =
      <SubmissionAnswersAttribute>[].obs;
  Rx<ChallengeSubmission?> currentChallengeSubmission =
      Rx<ChallengeSubmission?>(null);
  RxInt currentIndex = 0.obs;
  Rx<String>? currentSelectedAnswer = "".obs;
  RxList<SubmissionAnswer?> submissionAnswerList = <SubmissionAnswer>[].obs;

  @override
  void onInit() {
    getChallenge(id: challengeId);
    // create challenge submission
    super.onInit();
  }

  double get getProgress {
    return currentIndex / ((questionList?.length ?? 0) - 1);
  }

  Question? get currentQuestion => questionList?[currentIndex.value];

  SubmissionAnswer? get currentSubmissionAnswer =>
      submissionAnswerList.firstWhereOrNull(
          (element) => element?.questionId == currentQuestion?.id);

  bool get isSubmitted => currentSubmissionAnswer != null;

  bool isCorrect({required String answer}) =>
      currentSubmissionAnswer?.question?.answers?.first.text == answer;

  bool isWrong({required String answer}) =>
      (answer == currentSubmissionAnswer?.answer) &&
      currentSubmissionAnswer?.isCorrect == false;

  Future<void> onSubmitAnswer() async {
    await submissionAnswerRepo.createSubmissionAnswer(
        submissionAnswer: SubmissionAnswer(
            questionId: currentQuestion?.id,
            challengeSubmissionId: currentChallengeSubmission.value?.id,
            answer: currentSelectedAnswer?.value),
        onSuccess: (value) {
          submissionAnswerList.add(value);
          currentSelectedAnswer?.value == "";
        },
        onError: (error) {});
  }

  Future<void> getChallenge({required String id}) async {
    await challengeRepo.getChallenge(
        id: id,
        onSuccess: (value) {
          questionList?.value = value?.questions ?? [];
          getChallengeSubmissions(challengeId: id);
        },
        onError: (error) {});
  }

  Future<void> getChallengeSubmissions({required String challengeId}) async {
    await challengeSubmissionRepo.getChallengeSubmissions(
        queryParams: QueryParams(challengeId: challengeId),
        onSuccess: (value) {
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
        },
        onError: (error) {});
  }

  Future<void> createChallengeSubmission({required String challengeId}) async {
    await challengeSubmissionRepo.createChallengeSubmission(
        challengeSubmission: ChallengeSubmission(challengeId: challengeId),
        onSuccess: (value) {
          currentChallengeSubmission.value = value;
        },
        onError: (error) {});
  }

  void onSelectAnswer({required String answer}) {
    currentSelectedAnswer?.value = answer;
  }

  void nextQuestion() {
    currentIndex.value < ((questionList?.length ?? 0) - 1)
        ? currentIndex += 1
        : null;
  }

  void onBack() {
    currentIndex.value > 0 ? currentIndex -= 1 : Get.back();
  }
}
