import 'package:edupals/features/question-bank/domain/repository/subject_repository.dart';
import 'package:edupals/features/question-bank/presentation/controller/question_bank_controller.dart';
import 'package:get/get.dart';

class QuestionBankBinding extends Bindings {
  @override
  void dependencies() {
    // Register Repository
    Get.lazyPut<SubjectRepository>(() => SubjectRepository());
    // Register Controller
    Get.put<QuestionBankController>(QuestionBankController());
  }
}
