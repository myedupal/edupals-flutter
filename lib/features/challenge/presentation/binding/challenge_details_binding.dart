import 'package:edupals/features/challenge/domain/repository/challenge_submission_repository.dart';
import 'package:edupals/features/challenge/presentation/controller/challenge_details_controller.dart';
import 'package:get/get.dart';

class ChallengeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeSubmissionRepository());
    Get.lazyPut<ChallengeDetailsController>(() => ChallengeDetailsController());
  }
}
