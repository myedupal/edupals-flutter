import 'dart:convert';

import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/challenge/domain/model/submission_answer.dart';
import 'package:get/get.dart';

class SubmissionAnswerRepository {
  final DioClient dioClient = Get.find();

  Future<void> getSubmissionAnswers(
      {QueryParams? queryParams,
      required Function(List<SubmissionAnswer>?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getSubmissionAnswers,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              SubmissionAnswerWrapper.fromJson(value.data).submissionAnswers),
          onError: onError,
        );
  }

  Future<void> getSubmissionAnswer(
      {String? id,
      required Function(SubmissionAnswer?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getSubmissionAnswers}$id",
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              SubmissionAnswerWrapper.fromJson(value.data).submissionAnswer),
          onError: onError,
        );
  }

  Future<void> createSubmissionAnswer(
      {SubmissionAnswer? submissionAnswer,
      required Function(SubmissionAnswer?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.getSubmissionAnswers,
          body: jsonEncode(
              SubmissionAnswerWrapper(submissionAnswer: submissionAnswer)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              SubmissionAnswerWrapper.fromJson(value.data).submissionAnswer),
          onError: onError,
        );
  }

  Future<void> updateSubmissionAnswer(
      {SubmissionAnswer? submissionAnswer,
      required String id,
      required Function(SubmissionAnswer?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .put(
          "${ApiConstants.getSubmissionAnswers}$id",
          body: jsonEncode(
              SubmissionAnswerWrapper(submissionAnswer: submissionAnswer)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              SubmissionAnswerWrapper.fromJson(value.data).submissionAnswer),
          onError: onError,
        );
  }
}
