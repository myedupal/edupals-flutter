import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:get/get.dart';

class DailyChallengeController extends BaseController {
  final ChallengeRepository challengeRepo = Get.find();
  RxList<Challenge>? challengeList = <Challenge>[].obs;
  RxList<Question>? questionList = <Question>[].obs;
  RxList<SubmissionAnswersAttribute>? answeredList =
      <SubmissionAnswersAttribute>[].obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    getChallenges();
    // create challenge submission
    super.onInit();
  }

  double get getProgress {
    return currentIndex / ((questionList?.length ?? 0) - 1);
  }

  Question? get currentQuestion => questionList?[currentIndex.value];

  void onSubmitAnswer() {
    // add answer in answeredlist and keep calling updaate challenge submission
    // call update submission
  }

  Future<void> getChallenges() async {
    await challengeRepo.getChallenges(
        queryParams: QueryParams(
            fromStartAt: "2024-03-01T00:00:00+08:00",
            toStartAt: "2024-03-31T00:00:00+08:00"),
        onSuccess: (value) {
          challengeList?.value = value ?? [];
          if (challengeList?.isNotEmpty == true) {
            getChallenge(id: value?.first.id ?? "");
          }
        },
        onError: (error) {});
  }

  Future<void> getChallenge({required String id}) async {
    await challengeRepo.getChallenge(
        id: id,
        onSuccess: (value) {
          questionList?.value = value?.questions ?? [];
        },
        onError: (error) {});
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
