import 'package:edupals/features/challenge/domain/repository/challenge_submission_repository.dart';
import 'package:edupals/features/mcq/presentation/controller/submission_details_controller.dart';
import 'package:get/get.dart';

class SubmissionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeSubmissionRepository());
    Get.lazyPut<SubmissionDetailsController>(
        () => SubmissionDetailsController());
  }
}
