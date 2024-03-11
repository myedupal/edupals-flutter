import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/dashboard/domain/model/curriculum.dart';
import 'package:get/get.dart';

class CurriculumRepository {
  final DioClient dioClient = Get.find();

  Future<void> getCurriculum(
      {String? id,
      required Function(Curriculum?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getCurriculums}$id",
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(CurriculumWrapper.fromJson(value).curriculum),
          onError: onError,
        );
  }

  Future<void> getCurriculums(
      {QueryParams? queryParams,
      required Function(List<Curriculum>?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getCurriculums,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(CurriculumWrapper.fromJson(value).curriculums),
          onError: onError,
        );
  }
}
