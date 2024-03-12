import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';
import 'package:get/get.dart';

class TopicRepository {
  final DioClient dioClient = Get.find();

  Future<void> getTopic(
      {String? id,
      required Function(Topic?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getTopics}$id",
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(TopicWrapper.fromJson(value.data).topic),
          onError: onError,
        );
  }

  Future<void> getTopics(
      {QueryParams? queryParams,
      required Function(List<Topic>?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getTopics,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(TopicWrapper.fromJson(value.data).topics),
          onError: onError,
        );
  }
}
