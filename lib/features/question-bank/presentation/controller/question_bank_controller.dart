import 'package:edupals/features/question-bank/domain/model/subject.dart';
import 'package:edupals/features/question-bank/domain/repository/subject_repository.dart';
import 'package:get/get.dart';

class QuestionBankController extends GetxController {
  final SubjectRepository subjectRepo = Get.find();
  final RxList<Subject>? subjectList = <Subject>[].obs;
  // Get Subject List
  // Get paper list in subject list
  // Get topics

  @override
  void onInit() {
    super.onInit();
    getSubjects();
  }

  Future<void> getSubjects() async {
    await subjectRepo.getSubjects(
        onSuccess: (value) {
          subjectList?.value = value ?? [];
        },
        onError: (error) {});
  }
}
