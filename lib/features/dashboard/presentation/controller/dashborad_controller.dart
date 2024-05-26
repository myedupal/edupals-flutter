import 'package:edupals/core/base/main_controller.dart';
import 'package:edupals/features/dashboard/domain/model/dashboard_report.dart';
import 'package:edupals/features/dashboard/domain/model/point_report.dart';
import 'package:edupals/features/dashboard/domain/repository/dashboard_report_repository.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final MainController mainController = Get.find();
  final DashboardReportRepository dashboardReportRepo = Get.find();
  final Rx<DashboardReport?> dailyChallengeReport = Rx<DashboardReport?>(null);
  final Rx<DashboardReport?> mcqReport = Rx<DashboardReport?>(null);
  final Rx<PointReport?> pointReport = Rx<PointReport?>(null);

  @override
  void onInit() {
    mainController.selectedNavIndex.stream.listen((value) {
      if (mainController.currentNavName == "Dashboard") {
        getDailyChallengeReport();
        getMcqReport();
        getPointReport();
        mainController.getUser();
      }
    });
    getDailyChallengeReport();
    getMcqReport();
    getPointReport();
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

  void getPointReport() async {
    await dashboardReportRepo.getPointReport(
        onSuccess: (value) {
          pointReport.value = value;
        },
        onError: (error) {});
  }
}
