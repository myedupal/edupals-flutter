import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';
import 'package:get/get.dart';

class SubjectRepository {
  final DioClient dioClient = Get.find();

  Future<void> getSubject(
      {String? id,
      required Function(Subject?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getSubjects}$id",
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(SubjectWrapper.fromJson(value).subject),
          onError: onError,
        );
  }

  Future<void> getSubjects(
      {QueryParams? queryParams,
      required Function(List<Subject>?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getSubjects,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(SubjectWrapper.fromJson(value).subjects),
          onError: onError,
        );
  }
}
