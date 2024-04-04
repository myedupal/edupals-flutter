import 'package:edupals/features/question-bank/domain/repository/exam_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:edupals/features/question-bank/presentation/controller/questions_list_controller.dart';
import 'package:get/get.dart';

class QuestionsListBinding extends Bindings {
  @override
  void dependencies() {
    // Register Repository
    Get.lazyPut<UserQuestionsRepository>(() => UserQuestionsRepository());
    Get.lazyPut<ExamRepository>(() => ExamRepository());
    // Register Controller
    Get.lazyPut<QuestionsListController>(() => QuestionsListController());
  }
}
