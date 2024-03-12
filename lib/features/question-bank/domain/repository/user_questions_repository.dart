import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/base/model/tuple_response.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:get/get.dart';

class UserQuestionsRepository {
  final DioClient dioClient = Get.find();

  Future<void> getQuestion(
      {String? id,
      required Function(Question?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getQuestions}$id",
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(QuestionWrapper.fromJson(value.data).question),
          onError: onError,
        );
  }

  Future<void> getQuestions(
      {QueryParams? queryParams,
      required Function(TupleResponse<List<Question>?>) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getQuestions,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(TupleResponse(
              data: QuestionWrapper.fromJson(value.data).questions,
              pages: value.pages,
              counts: value.counts)),
          onError: onError,
        );
  }
}
