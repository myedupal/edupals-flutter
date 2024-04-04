import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/routes/app_routes.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/domain/repository/activity_repository.dart';
import 'package:edupals/features/question-bank/domain/model/question_bank_argument.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends BaseController {
  final ActivityRepository acitvityRepo = Get.find();
  final MainController mainController = Get.find();
  QueryParams? activityListParams = QueryParams(items: 100, page: 1);
  RxList<Activity> activityList = <Activity>[].obs;
  RxInt activityTotalPage = 1.obs;

  @override
  void onInit() {
    mainController.selectedNavIndex.stream.listen((value) {
      if (mainController.currentNavName == "History") {
        refreshHistory();
      }
    });
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
