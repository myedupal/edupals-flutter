import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_repository.dart';
import 'package:get/get.dart';

class DailyChallengeController extends BaseController {
  final ChallengeRepository challengeRepo = Get.find();
  RxList<Challenge>? challengeList = <Challenge>[].obs;

  @override
  void onInit() {
    getChallenges();
    super.onInit();
  }

  Future<void> getChallenges() async {
    setLoading();
    await challengeRepo.getChallenges(
        // queryParams: QueryParams(
        // fromStartAt: "2024-03-01T00:00:00+08:00",
        // toStartAt: "2024-03-31T00:00:00+08:00"),
        onSuccess: (value) {
          if (value?.isEmpty == true) {
            setNoData();
          } else {
            setSuccess();
            challengeList?.value = value ?? [];
          }
        },
        onError: (error) {});
  }
}
