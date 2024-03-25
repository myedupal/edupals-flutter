import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/question-bank/domain/model/exam.dart';
import 'package:get/get.dart';

class ExamRepository {
  final DioClient dioClient = Get.find();

  Future<void> getExam(
      {String? id,
      required Function(Exam?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getExams}$id",
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(ExamWrapper.fromJson(value.data).exam),
          onError: onError,
        );
  }

  Future<void> getExams(
      {QueryParams? queryParams,
      required Function(List<Exam>?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getExams,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(ExamWrapper.fromJson(value.data).exams),
          onError: onError,
        );
  }
}
