import 'package:edupals/core/base/base_dialog.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/string_extensions.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/question_filter_argument.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/subject_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/topic_repository.dart';
import 'package:get/get.dart';

class QuestionFilterSegmentController extends GetxController {
  // Repository and controller DI
  final SubjectRepository subjectRepo = Get.find();
  final TopicRepository topicRepo = Get.find();
  final MainController mainController = Get.find();

  // General State
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
  final List<KeyValue> zoneList = [
    KeyValue(label: "Zone 1", key: "1"),
    KeyValue(label: "Zone 2", key: "2"),
    KeyValue(label: "Zone 3", key: "3")
  ];
  RxList<KeyValue>? selectedTopics = <KeyValue>[].obs;
  RxList<KeyValue>? selectedYears = <KeyValue>[].obs;
  Rx<KeyValue?> selectedZone = Rx<KeyValue?>(null);
  Rx<KeyValue?> selectedRevisionType = Rx<KeyValue?>(null);
  Rx<KeyValue?> selectedSeason = Rx<KeyValue?>(null);
  Rx<KeyValue?> selectedSubject = Rx<KeyValue?>(null);
  Rx<KeyValue?> selectedPaper = Rx<KeyValue?>(null);

  @override
  void onInit() {
    super.onInit();
    selectedRevisionType.value = revisionType.first;
    getSubjects();
    mainController.selectedCurriculum.stream.listen((value) {
      getSubjects(isReset: true);
      resetFilter();
    });
  }

  bool get isYearly => selectedRevisionType.value?.key == "yearly";

  void onSetFilterArgument({QuestionFilterArgument? value}) {
    if (value?.subject != null) {
      selectedSubject.value = value?.subject;
      getTopics();
      getSubjects();
    }
  }

  void resetFilter() {
    selectedPaper.value = null;
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

  void onSelectZone({KeyValue? value}) {
    selectedZone.value = value;
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

  bool validateYearly() {
    return (selectedSubject.value == null ||
        selectedPaper.value == null ||
        selectedSeason.value == null ||
        selectedYears?.isNotEmpty == false ||
        selectedZone.value == null);
  }

  bool validateMonthly() {
    return (selectedSubject.value == null ||
        selectedPaper.value == null ||
        selectedSeason.value == null);
  }

  QuestionBankArgument? get compiledValue {
    final QuestionBankArgument argument = QuestionBankArgument(
        revisionType: selectedRevisionType.value?.key,
        title:
            "${selectedRevisionType.value?.label ?? ""}|${selectedSubject.value?.label ?? ""}|Paper ${selectedPaper.value?.label ?? ""}|${selectedSeason.value?.label ?? ""} Season",
        queryParams: QueryParams(
          page: 1,
          items: 100,
          sortBy: "topic",
          zone: selectedZone.value != null
              ? [selectedZone.value?.key ?? ""]
              : null,
          subjectId: selectedSubject.value?.key,
          paperId: selectedPaper.value?.key ?? "",
          topicId: selectedTopics?.map((element) => element.key ?? "").toList(),
          year: selectedYears?.map((element) => element.key ?? "").toList(),
          season: selectedSeason.value != null
              ? [selectedSeason.value?.key?.toCapitalized() ?? ""]
              : null,
        ));

    if (isYearly ? validateYearly() : validateMonthly()) {
      triggerError(error: "Please select all required field");
      return null;
    } else {
      return argument;
    }
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

  Future<void> getSubjects({bool isReset = false}) async {
    await subjectRepo.getSubjects(
        queryParams: QueryParams(
            curriculumId: mainController.selectedCurriculum.value?.id),
        onSuccess: (value) {
          subjectList?.value = value ?? [];
          if (isReset) selectedSubject.value = null;
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
