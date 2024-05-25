import 'package:edupals/core/base/base_controller.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:edupals/features/challenge/domain/repository/challenge_submission_repository.dart';
import 'package:get/get.dart';

class MCQController extends BaseController {
  final ChallengeSubmissionRepository challengeSubmissionRepo = Get.find();
  RxList<ChallengeSubmission>? submissionList = <ChallengeSubmission>[].obs;
  QueryParams? submissionListParams =
      QueryParams(page: 1, items: 100, status: "submitted", mcq: false);

  @override
  void onInit() {
    getSubmissions();
    super.onInit();
  }

  Future<void> getSubmissions() async {
    setLoading();
    await challengeSubmissionRepo.getChallengeSubmissions(
        queryParams: submissionListParams,
        onSuccess: (value) {
          if (value?.isEmpty == true) {
            setNoData();
          } else {
            setSuccess();
            submissionList?.value = value ?? [];
          }
        },
        onError: (error) {});
  }
}
