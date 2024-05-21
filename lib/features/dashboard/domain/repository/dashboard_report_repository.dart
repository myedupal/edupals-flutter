import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/dashboard/domain/model/dashboard_report.dart';
import 'package:get/get.dart';

class DashboardReportRepository {
  final DioClient dioClient = Get.find();

  Future<void> getDailyChallengeReport(
      {required Function(DashboardReport?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getDailyChallengeReport,
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(DashboardReport.fromJson(value.data)),
          onError: onError,
        );
  }

  Future<void> getMcqReport(
      {required Function(DashboardReport?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getMcqReport,
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(DashboardReport.fromJson(value.data)),
          onError: onError,
        );
  }
}
