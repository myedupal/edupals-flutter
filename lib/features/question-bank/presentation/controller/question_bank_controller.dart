import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/subject_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/topic_repository.dart';
import 'package:get/get.dart';

class QuestionBankController extends GetxController {
  final SubjectRepository subjectRepo = Get.find();
  final TopicRepository topicRepo = Get.find();
  final RxList<Subject>? subjectList = <Subject>[].obs;
  final RxList<Topic>? topicList = <Topic>[].obs;
  Rx<KeyValue?> selectedSubject = KeyValue().obs;
  // Get Subject List
  // Get paper list in subject list
  // Get topics

  @override
  void onInit() {
    super.onInit();
    getSubjects();
  }

  void onSelectSubject({KeyValue? value}) {
    selectedSubject.value = value;
    getTopics();
  }

  List<KeyValue>? get paperList => subjectList
      ?.firstWhereOrNull((element) => element.id == selectedSubject.value?.key)
      ?.papers
      ?.map((e) => KeyValue(label: e.name, key: e.id))
      .toList();

  Future<void> getSubjects() async {
    await subjectRepo.getSubjects(
        onSuccess: (value) {
          subjectList?.value = value ?? [];
        },
        onError: (error) {});
  }

  Future<void> getTopics() async {
    await topicRepo.getTopics(
        queryParams: QueryParams(subjectId: selectedSubject.value?.key),
        onSuccess: (value) {
          topicList?.value = value ?? [];
        },
        onError: (error) {});
  }
}
