import 'dart:async';
import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/domain/model/activity_question.dart';
import 'package:edupals/features/history/domain/repository/activity_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:edupals/features/question-bank/domain/repository/activity_question_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/exam_repository.dart';
import 'package:edupals/features/question-bank/domain/repository/user_questions_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsListController extends BaseController {
  // Controller and repository DI
  final ExamRepository examRepo = Get.find();
  final UserQuestionsRepository questionsRepo = Get.find();
  final ActivityQuestionRepository activityQuestionRepo = Get.find();
  final ActivityRepository activityRepo = Get.find();
  final MainController mainController = Get.find();
  // Timer State
  MyStopWatch stopwatch = MyStopWatch();
  late Timer _timer;
  RxString formattedTime = '00:00:00'.obs;
  RxInt elapsedSeconds = 0.obs;
  RxInt initSecond = 0.obs;
  // General State
  final QuestionBankArgument routeArgument = Get.arguments;
  Rx<QuestionBankArgument?> currentArgument = Rx<QuestionBankArgument?>(null);
  QueryParams? questionListParams;
  RxList<Question> questionsList = <Question>[].obs;
  RxList<Topic?>? topicList = <Topic?>[].obs;
  Rx<Question?> selectedQuestion = Question().obs;
  RxInt questionTotalPage = 1.obs;
  Rx<Activity?> currentActivity = Rx<Activity?>(null);
  bool isHistory = false;
  List<String>? questionMemoryList = [];

  @override
  void onClose() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      _timer.cancel(); // Stop the timer when the page is closed
      mainController.onTerminateStopWatch(
          time: elapsedSeconds.value, activityId: currentActivity.value?.id);
    }
    super.onClose();
  }

  @override
  void onInit() {
    onSetArgument(value: routeArgument);
    super.onInit();
  }

  void onSetArgument({QuestionBankArgument? value}) {
    currentArgument.value = value;
    if (value?.queryParams != null) {
      questionListParams = value?.queryParams;
    }
    (value?.revisionType == "yearly" && value?.isHistory == false)
        ? getExam()
        : getQuestions();
    final activity = value?.activity;
    if (activity != null) {
      currentActivity.value = activity;
      initSecond.value = activity.recordedTime ?? 0;
      formattedTime.value = formatDuration(Duration(seconds: initSecond.value));
    }
  }

  // Timer Function
  void startStopwatch() {
    stopwatch.start();
    if (elapsedSeconds.value == 0) {
      stopwatch.seconds = initSecond.value;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      formattedTime.value = stopwatch.elapsedDuration.toString().split('.')[0];
      elapsedSeconds.value = stopwatch.elapsedSeconds;
      debugPrint("${stopwatch.elapsedSeconds}");
    });
  }

  void stopStopwatch() {
    stopwatch.stop();
    _timer.cancel();
    updateActivity(activity: Activity(recordedTime: elapsedSeconds.value));
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void resetStopwatch() {
    stopwatch.reset();
    formattedTime.value = '00:00:00';
  }

  bool get isMemoryAvailable =>
      questionMemoryList?.firstWhereOrNull(
          (element) => element == selectedQuestion.value?.id) !=
      null;

  void onSelectQuestion({required Question question}) {
    selectedQuestion.value = question;
    if (!isMemoryAvailable) {
      questionMemoryList?.add(question.id ?? "");
      createActivityQuestion();
    }
  }

  List<String> get titleList =>
      (currentArgument.value?.title ?? currentActivity.value?.title)
          ?.split("|") ??
      [];

  bool get isYearly => currentArgument.value?.revisionType == "yearly";

  double get getProgress {
    final calculatedProgress =
        (currentActivity.value?.activityQuestionsCount ?? 0) /
            (currentActivity.value?.questionsCount ?? 0);
    return calculatedProgress.isNaN ? 0 : calculatedProgress;
  }

  String? get yearsRange {
    String finalRange = "-";
    final paramsYears = questionListParams?.year;
    paramsYears?.sort();
    switch (paramsYears?.length ?? 0) {
      case 1:
        finalRange = "${paramsYears?.first} Year";
      case > 2:
        finalRange = "From ${paramsYears?.first} to ${paramsYears?.last}";
      default:
        finalRange = "-";
    }
    return finalRange;
  }

  void questionAction(String action) {
    final filteredQuestionIndex = questionsList
        .indexWhere((element) => element.id == selectedQuestion.value?.id);
    switch (action) {
      case "back":
        if (filteredQuestionIndex != 0) {
          final question = questionsList[(filteredQuestionIndex) - 1];
          selectedQuestion.value = question;
          if (!isMemoryAvailable) {
            questionMemoryList?.add(question.id ?? "");
            createActivityQuestion();
          }
        }
      case "next":
        if (filteredQuestionIndex != (questionsList.length) - 1) {
          final question = questionsList[(filteredQuestionIndex) + 1];
          selectedQuestion.value = question;
          if (!isMemoryAvailable) {
            questionMemoryList?.add(question.id ?? "");
            createActivityQuestion();
          }
        }
    }
  }

  Future<void> getQuestions({bool loadMore = false}) async {
    int page = questionListParams?.page ?? 1;
    if (loadMore) {
      questionListParams?.page = page + 1;
    } else {
      setLoading();
    }
    await questionsRepo.getQuestions(
        queryParams: questionListParams,
        onSuccess: (value) {
          loadMore
              ? questionsList = (questionsList) + (value.data ?? [])
              : {
                  questionsList.value = value.data ?? [],
                  if (questionsList.isNotEmpty == true &&
                      currentArgument.value?.isHistory == false)
                    createActivity()
                };

          questionsList.isNotEmpty == true
              ? {
                  processData(),
                  questionTotalPage.value = int.parse(value.pages ?? "1"),
                  setSuccess()
                }
              : setNoData();
        },
        onError: (error) {});
  }

  Future<void> getExam() async {
    setLoading();
    await examRepo.getExams(
        queryParams: questionListParams,
        onSuccess: (value) {
          (value?.isNotEmpty == true)
              ? {
                  questionListParams?.examId = [value?.first.id ?? ""],
                  getQuestions()
                }
              : setNoData();
        },
        onError: (error) {});
  }

  Future<void> createActivity() async {
    await activityRepo.createActivity(
        activity: Activity(
          title: currentArgument.value?.title,
          subjectId: questionListParams?.subjectId,
          activityType: currentArgument.value?.revisionType,
          topicIds: questionListParams?.topicId,
          // This will cause issue because current using paper_name
          paperIds: [questionListParams?.paperId ?? ""],
          metadata: questionListParams,
          examId: questionListParams?.examId?.first,
        ),
        onSuccess: (value) {
          currentActivity.value = value;
        },
        onError: (error) {});
  }

  Future<void> updateActivity({Activity? activity}) async {
    await activityRepo.updateActivity(
        activity: activity,
        id: currentActivity.value?.id ?? "",
        onSuccess: (value) {
          currentActivity.value = value;
        },
        onError: (error) {});
  }

  Future<void> createActivityQuestion() async {
    await activityQuestionRepo.createActivityQuestion(
        activityQuestion: ActivityQuestion(
          activityId: currentActivity.value?.id,
          questionId: selectedQuestion.value?.id,
        ),
        onSuccess: (value) {
          currentActivity.value = value?.activity;
        },
        onError: (error) {});
  }

  void processData() {
    topicList?.value = [];
    if (isYearly) {
      questionsList.sort((a, b) =>
          int.parse(a.number ?? "1").compareTo(int.parse(b.number ?? "1")));
    } else {
      for (int i = 0; i < (questionsList.length); i++) {
        if (questionsList[i].topics?.isEmpty == true) {
          questionsList[i].topics = [Topic(id: "No Topic", name: "No Topic")];
        }
        final topic = topicList?.firstWhereOrNull((element) =>
            element?.id == (questionsList[i].topics?.first.id ?? ""));
        if (topic == null) {
          topicList?.add(questionsList[i].topics?.first);
        }
      }
    }
    selectedQuestion.value = questionsList.first;
  }

  int compareQuestions(Question a, Question b) {
    int zoneComparison = a.exam?.zone?.compareTo(b.exam?.zone ?? "") ?? 0;
    if (zoneComparison != 0) {
      return zoneComparison;
    }

    int topicComparison =
        a.topics?[0].name?.compareTo(b.topics?[0].name ?? "") ?? 0;
    if (topicComparison != 0) {
      return topicComparison;
    }

    return a.number?.compareTo(b.number ?? "") ?? 0;
  }
}

class MyStopWatch extends Stopwatch {
  int _starterSeconds = 0;

  MyStopWatch();

  get elapsedDuration {
    return Duration(
        seconds: int.parse("${(elapsedMilliseconds / 1000).round()}") +
            _starterSeconds);
  }

  get elapsedSeconds {
    return (elapsedMilliseconds / 1000).round() + _starterSeconds;
  }

  set seconds(int timeInSeconds) {
    _starterSeconds = timeInSeconds;
  }
}
