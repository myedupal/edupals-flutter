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

enum QuestionFilterType { mcq, all }

class QuestionFilterSegmentController extends GetxController {
  // Repository and controller DI
  final SubjectRepository subjectRepo = Get.find();
  final TopicRepository topicRepo = Get.find();
  final MainController mainController = Get.find();

  // General State
  QuestionFilterType? questionFilterType = QuestionFilterType.all;
  final RxList<Subject>? subjectList = <Subject>[].obs;
  final RxList<Topic>? topicList = <Topic>[].obs;
  final RxList<KeyValue> revisionType = [
    KeyValue(label: "Topical", key: "topical"),
    KeyValue(label: "Yearly", key: "yearly")
  ].obs;
  final RxList<KeyValue> season = [
    KeyValue(label: "Summer", key: "summer"),
    KeyValue(label: "Winter", key: "winter")
  ].obs;
  final RxList<KeyValue> yearsList = [KeyValue(label: "2023", key: "2023")].obs;
  final RxList<KeyValue> paperList =
      [KeyValue(label: "Paper 1", key: "Paper 1")].obs;
  final RxList<KeyValue> zoneList = [
    KeyValue(label: "Zone 1", key: "1"),
    KeyValue(label: "Zone 2", key: "2"),
    KeyValue(label: "Zone 3", key: "3")
  ].obs;
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
    }

    if (value?.revisionType != null) {
      selectedRevisionType.value = revisionType
          .firstWhere((element) => element.key == value?.revisionType);
    } else {
      selectedRevisionType.value = revisionType.first;
    }

    if (value?.questionFilterType != null) {
      questionFilterType = value?.questionFilterType;
    }
    getSubjects();
  }

  void resetFilter() {
    selectedPaper.value = null;
    selectedTopics?.value = [];
    selectedYears?.value = [];
    selectedZone.value = null;
    selectedSeason.value = null;
  }

  void onSelectSubject({KeyValue? value}) {
    selectedSubject.value = value;
    getTopics();
    resetFilter();
    onResetData();
  }

  void onResetData() {
    final filteredSubject = subjectList?.firstWhereOrNull(
        (element) => element.id == selectedSubject.value?.key);
    final ExamsFiltering? examAttribute =
        questionFilterType == QuestionFilterType.mcq
            ? filteredSubject?.examsFiltering?.mcq
            : filteredSubject?.examsFiltering?.all;
    examAttribute?.years?.sort((a, b) => b.compareTo(a));
    zoneList.value = examAttribute?.zones
            ?.map((e) => KeyValue(label: "Zone $e", key: e))
            .toList() ??
        [];
    season.value = examAttribute?.seasons
            ?.map((e) => KeyValue(label: e.toCapitalized(), key: e))
            .toList() ??
        [];
    yearsList.value = examAttribute?.years
            ?.map((e) => KeyValue(label: "$e", key: "$e"))
            .toList() ??
        [];

    paperList.value = examAttribute?.papers
            ?.map((e) => KeyValue(label: e, key: e))
            .toList() ??
        [];
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

  String get getTitle {
    return questionFilterType == QuestionFilterType.mcq
        ? "${selectedSubject.value?.label ?? ""}|Paper ${selectedPaper.value?.label ?? ""}|${selectedSeason.value?.label ?? ""} Season|Year ${selectedYears?.first.key}|Zone ${selectedZone.value?.key}"
        : "${selectedRevisionType.value?.label ?? ""}|${selectedSubject.value?.label ?? ""}|Paper ${selectedPaper.value?.label ?? ""}|${selectedSeason.value?.label ?? ""} Season";
  }

  QuestionBankArgument? get compiledValue {
    final QuestionBankArgument argument = QuestionBankArgument(
        revisionType: selectedRevisionType.value?.key,
        title: getTitle,
        subject: selectedSubject.value,
        paper: "Paper ${selectedPaper.value?.label ?? ""}",
        queryParams: QueryParams(
          page: 1,
          items: 100,
          sortBy: "topic",
          zone: selectedZone.value != null
              ? [selectedZone.value?.key ?? ""]
              : null,
          subjectId: selectedSubject.value?.key,
          paperName: selectedPaper.value?.key ?? "",
          // paperId: selectedPaper.value?.key ?? "",
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

  Future<void> getSubjects({bool isReset = false}) async {
    await subjectRepo.getSubjects(
        queryParams: QueryParams(
            hasMcqQuestions: questionFilterType == QuestionFilterType.mcq,
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
