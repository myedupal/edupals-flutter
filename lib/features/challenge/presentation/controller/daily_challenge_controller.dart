import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_repository.dart';
import 'package:get/get.dart';

class DailyChallengeController extends BaseController {
  final ChallengeRepository challengeRepo = Get.find();
  RxList<Challenge>? challengeList = <Challenge>[].obs;
  RxList<String>? subjectList = <String>[].obs;

  @override
  void onInit() {
    getChallenges();
    super.onInit();
  }

  Future<void> getChallenges() async {
    await challengeRepo.getChallenges(
        queryParams: QueryParams(
            fromStartAt: "2024-03-01T00:00:00+08:00",
            toStartAt: "2024-03-31T00:00:00+08:00"),
        onSuccess: (value) {
          challengeList?.value = value ?? [];
          filterSubjects();
        },
        onError: (error) {});
  }

  void filterSubjects() {
    for (int i = 0; i < (challengeList?.length ?? 0); i++) {
      final subjectName = challengeList?[i].subject?.name;
      final subject =
          subjectList?.firstWhereOrNull((element) => element == subjectName);
      if (subject == null) {
        subjectList?.add(subjectName ?? "");
      }
    }
  }
}
