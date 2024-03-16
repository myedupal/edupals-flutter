import 'package:edupals/core/base/base_controller.dart';
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
    return currentIndex / (questionList?.length ?? 0);
  }

  void onSubmitAnswer() {
    // add answer in answeredlist and keep calling updaate challenge submission
    // call update submission
  }

  Future<void> getChallenges() async {
    await challengeRepo.getChallenges(
        onSuccess: (value) {
          challengeList?.value = value ?? [];
          if (challengeList?.isNotEmpty == true) {
            questionList?.value = value?.first.questions ?? [];
          }
        },
        onError: (error) {});
  }
}
