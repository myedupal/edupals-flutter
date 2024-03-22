import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/string_extensions.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/subject_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/topic_repository.dart';
import 'package:get/get.dart';

class QuestionBankController extends GetxController {
  final SubjectRepository subjectRepo = Get.find();
  final TopicRepository topicRepo = Get.find();
  final MainController mainController = Get.find();
  final RxList<Subject>? subjectList = <Subject>[].obs;
  final RxList<Topic>? topicList = <Topic>[].obs;
  final List<KeyValue> revisionType = [
    KeyValue(label: "Topical", key: "topical"),
    KeyValue(label: "Yearly", key: "yearly")
  ];
  final List<KeyValue> season = [
    KeyValue(label: "Summer", key: "summer"),
    KeyValue(label: "Winter", key: "winter")
  ];
  RxList<KeyValue>? selectedTopics = <KeyValue>[].obs;
  RxList<KeyValue>? selectedYears = <KeyValue>[].obs;
  Rx<KeyValue?> selectedRevisionType = KeyValue().obs;
  Rx<KeyValue?> selectedSeason = Rx<KeyValue?>(null);
  Rx<KeyValue?> selectedSubject = Rx<KeyValue?>(null);
  Rx<KeyValue?> selectedPaper = Rx<KeyValue?>(null);

  @override
  void onInit() {
    super.onInit();
    selectedRevisionType.value = revisionType.first;
    mainController.selectedCurriculum.stream.listen((value) {
      getSubjects();
      resetFilter();
    });
    getSubjects();
  }

  void resetFilter() {
    selectedPaper.value = KeyValue();
    selectedTopics?.value = [];
    selectedYears?.value = [];
  }

  void onSelectSubject({KeyValue? value}) {
    selectedSubject.value = value;
    getTopics();
    resetFilter();
  }

  void onSelectPaper({KeyValue? value}) {
    selectedPaper.value = value;
  }

  void onSelectTopics({List<KeyValue>? value}) {
    selectedTopics?.value = value ?? [];
  }

  void onSelectRevisionType({KeyValue? value}) {
    selectedRevisionType.value = value;
    selectedYears?.value = [];
    selectedTopics?.value = [];
  }

  void onSelectYears({List<KeyValue>? value}) {
    selectedYears?.value = value ?? [];
  }

  void onSelectSeason({KeyValue? value}) {
    selectedSeason.value = value;
  }

  void onRemoveTopic(String? key) {
    selectedTopics?.removeWhere((element) => element.key == key);
  }

  void onRemoveYear(String? key) {
    selectedYears?.removeWhere((element) => element.key == key);
  }

  void navigatePage() {
    final QuestionBankArgument argument = QuestionBankArgument(
        revisionType: selectedRevisionType.value?.key,
        titleList: [
          selectedRevisionType.value?.label ?? "",
          selectedSubject.value?.label ?? "",
          "Paper ${selectedPaper.value?.label ?? ""}",
          "${selectedSeason.value?.label ?? ""} Season"
        ],
        queryParams: QueryParams(
          page: 1,
          items: 100,
          sortBy: "topic",
          subjectId: selectedSubject.value?.key,
          topicId: selectedTopics?.map((element) => element.key ?? "").toList(),
          year: selectedYears?.map((element) => element.key ?? "").toList(),
          season: selectedSeason.value?.key?.toCapitalized(),
        ));

    (selectedSubject.value == null ||
            selectedPaper.value == null ||
            selectedSeason.value == null)
        ? triggerError(error: "Please select all required field")
        : Get.toNamed(Routes.questionsList, arguments: argument);
  }

  bool isAbleSelectSubject() {
    return mainController.selectedCurriculum.value != null;
  }

  void triggerError({String? error}) {
    BaseDialog.showError(subtitle: error);
  }

  List<KeyValue>? get yearsList {
    final currentYear = DateTime.now().year - 1;
    final yearList = List<KeyValue>.generate(
        15,
        (index) => KeyValue(
            label: "${currentYear - index}", key: "${currentYear - index}"));
    return yearList;
  }

  List<KeyValue>? get paperList => subjectList
      ?.firstWhereOrNull((element) => element.id == selectedSubject.value?.key)
      ?.papers
      ?.map((e) => KeyValue(label: e.name, key: e.id))
      .toList();

  Future<void> getSubjects() async {
    await subjectRepo.getSubjects(
        queryParams: QueryParams(
            curriculumId: mainController.selectedCurriculum.value?.id),
        onSuccess: (value) {
          subjectList?.value = value ?? [];
          selectedSubject.value = null;
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
