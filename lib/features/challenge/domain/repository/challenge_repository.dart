import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:get/get.dart';

class ChallengeRepository {
  final DioClient dioClient = Get.find();

  Future<void> getChallenge(
      {String? id,
      required Function(Challenge?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getChallenges}$id",
          authorization: false,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(ChallengeWrapper.fromJson(value.data).challenge),
          onError: onError,
        );
  }

  Future<void> getChallenges(
      {QueryParams? queryParams,
      required Function(List<Challenge>?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getChallenges,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(ChallengeWrapper.fromJson(value.data).challenges),
          onError: onError,
        );
  }
}
