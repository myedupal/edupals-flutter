import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/exam-builder/domain/model/user_exam.dart';
import 'package:edupals/features/exam-builder/domain/repository/user_exam_repository.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/domain/repository/activity_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends BaseController {
  // Repository
  final ActivityRepository acitvityRepo = Get.find();
  final UserExamRepository userExamRepo = Get.find();
  // General State
  final MainController mainController = Get.find();
  QueryParams? activityListParams = QueryParams(items: 100, page: 1);
  QueryParams? userExamListParams = QueryParams(items: 100, page: 1);
  RxList<Activity> activityList = <Activity>[].obs;
  RxList<UserExam> userExamList = <UserExam>[].obs;
  RxInt activityTotalPage = 1.obs;
  RxInt userExamTotalPage = 1.obs;

  @override
  void onInit() {
    mainController.selectedNavIndex.stream.listen((value) {
      if (mainController.currentNavName == "History") {
        refreshHistory();
        refreshUserExam();
      }
    });
    getUserExams();
    getHistory();
    super.onInit();
  }

  Future<void> getHistory({bool loadMore = false}) async {
    int page = activityListParams?.page ?? 1;
    if (loadMore) {
      activityListParams?.page = page + 1;
    } else {
      setLoading();
    }
    await acitvityRepo.getActivities(
        queryParams: activityListParams,
        onSuccess: (value) {
          loadMore
              ? activityList = (activityList) + (value.data ?? [])
              : activityList.value = value.data ?? [];

          activityList.isNotEmpty == true
              ? {
                  activityTotalPage.value = int.parse(value.pages ?? "1"),
                  setSuccess()
                }
              : setNoData();
        },
        onError: (error) {});
  }

  Future<void> getUserExams({bool loadMore = false}) async {
    int page = userExamListParams?.page ?? 1;
    if (loadMore) {
      userExamListParams?.page = page + 1;
    } else {
      setLoading();
    }
    await userExamRepo.getUserExams(
        queryParams: userExamListParams,
        onSuccess: (value) {
          loadMore
              ? userExamList = (userExamList) + (value.data ?? [])
              : userExamList.value = value.data ?? [];

          userExamList.isNotEmpty == true
              ? {
                  userExamTotalPage.value = int.parse(value.pages ?? "1"),
                  setSuccess()
                }
              : setNoData();
        },
        onError: (error) {});
  }

  void refreshUserExam() {
    userExamListParams?.page = 1;
    getUserExams();
  }

  void refreshHistory() {
    activityListParams?.page = 1;
    getHistory();
  }

  void navigatePage({Activity? activity}) {
    QueryParams? queryParams = activity?.metadata;
    queryParams?.paperId =
        activity?.paperIds?.isEmpty == true ? null : activity?.paperIds?.first;
    queryParams?.subjectId = activity?.subjectId;
    if (activity?.activityType == "yearly") {
      queryParams?.examId = [activity?.examId ?? ""];
    }
    queryParams?.topicId = activity?.topicIds;
    debugPrint("${queryParams?.toJson()}");
    Get.toNamed(Routes.questionsList,
        arguments: QuestionBankArgument(
            isHistory: true,
            activity: activity,
            revisionType: activity?.activityType,
            queryParams: queryParams));
  }

  void deleteActivity({String? id}) {
    acitvityRepo.deleteActivity(
        id: id ?? "", onSuccess: (value) {}, onError: (error) {});
  }
}
