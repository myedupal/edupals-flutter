import 'package:edupals/features/exam-builder/presentation/controller/exam_builder_details_controller.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:get/get.dart';

class ExamBuilderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserQuestionsRepository());
    Get.lazyPut<ExamBuilderDetailsController>(
        () => ExamBuilderDetailsController());
  }
}
