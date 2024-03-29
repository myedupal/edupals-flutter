import 'dart:convert';

import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/challenge/domain/model/challenge_submission.dart';
import 'package:get/get.dart';

class ChallengeSubmissionRepository {
  final DioClient dioClient = Get.find();

  Future<void> getChallengeSubmissions(
      {QueryParams? queryParams,
      required Function(List<ChallengeSubmission>?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getChallengeSubmissions,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              ChallengeSubmissionWrapper.fromJson(value.data)
                  .challengeSubmissions),
          onError: onError,
        );
  }

  Future<void> getChallengeSubmission(
      {String? id,
      required Function(ChallengeSubmission?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getChallengeSubmissions}$id",
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              ChallengeSubmissionWrapper.fromJson(value.data)
                  .challengeSubmission),
          onError: onError,
        );
  }

  Future<void> createChallengeSubmission(
      {ChallengeSubmission? challengeSubmission,
      required Function(ChallengeSubmission?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.getChallengeSubmissions,
          body: jsonEncode(ChallengeSubmissionWrapper(
              challengeSubmission: challengeSubmission)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              ChallengeSubmissionWrapper.fromJson(value.data)
                  .challengeSubmission),
          onError: onError,
        );
  }

  Future<void> updateChallengeSubmission(
      {ChallengeSubmission? challengeSubmission,
      required String id,
      required Function(ChallengeSubmission?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .put(
          "${ApiConstants.getChallengeSubmissions}$id",
          body: jsonEncode(ChallengeSubmissionWrapper(
              challengeSubmission: challengeSubmission)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              ChallengeSubmissionWrapper.fromJson(value.data)
                  .challengeSubmission),
          onError: onError,
        );
  }
}
