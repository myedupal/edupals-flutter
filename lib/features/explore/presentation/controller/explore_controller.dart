import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_repository.dart';
import 'package:get/get.dart';

class ExploreController extends BaseController {
  final ChallengeRepository challengeRepo = Get.find();
  RxList<Challenge>? challengeList = <Challenge>[].obs;
  final MainController mainController = Get.find();

  @override
  void onInit() {
    setupListeners();
    getChallenges();
    super.onInit();
  }

  void setupListeners() {
    everAll([mainController.currentUser, mainController.selectedNavIndex], (_) {
      if (mainController.currentNavName == "Explore") {
        getChallenges();
      }
    });
  }

  Future<void> getChallenges() async {
    setLoading();
    await challengeRepo.getChallenges(
        // queryParams: QueryParams(
        // curriculumId: mainController.selectedCurriculum.value?.id,
        // fromStartAt: "2024-07-01T00:00:00+08:00",
        // toStartAt: "2024-07-01T23:59:59+08:00"
        // ),
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
