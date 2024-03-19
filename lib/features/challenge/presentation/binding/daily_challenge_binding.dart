import 'package:edupals/features/challenge/domain/repository/challenge_repository.dart';
import 'package:edupals/features/challenge/presentation/controller/daily_challenge_controller.dart';
import 'package:get/get.dart';

class DailyChallengeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeRepository());
    Get.lazyPut<DailyChallengeController>(() => DailyChallengeController());
  }
}
