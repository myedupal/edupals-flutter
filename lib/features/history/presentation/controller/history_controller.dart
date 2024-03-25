import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/domain/repository.dart/activity_repository.dart';
import 'package:get/get.dart';

class HistoryController extends BaseController {
  final ActivityRepository acitvityRepo = Get.find();
  QueryParams? activityListParams = QueryParams(items: 100, page: 1);
  RxList<Activity> activityList = <Activity>[].obs;
  RxInt activityTotalPage = 1.obs;

  @override
  void onInit() {
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
}
