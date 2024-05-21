import 'package:edupals/features/dashboard/domain/model/dashboard_report.dart';
import 'package:edupals/features/dashboard/domain/repository/dashboard_report_repository.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final DashboardReportRepository dashboardReportRepo = Get.find();
  final Rx<DashboardReport?> dailyChallengeReport = Rx<DashboardReport?>(null);
  final Rx<DashboardReport?> mcqReport = Rx<DashboardReport?>(null);

  @override
  void onInit() {
    getDailyChallengeReport();
    getMcqReport();
    super.onInit();
  }

  void getDailyChallengeReport() async {
    await dashboardReportRepo.getDailyChallengeReport(
        onSuccess: (value) {
          dailyChallengeReport.value = value;
        },
        onError: (error) {});
  }

  void getMcqReport() async {
    await dashboardReportRepo.getMcqReport(
        onSuccess: (value) {
          mcqReport.value = value;
        },
        onError: (error) {});
  }
}
