import 'dart:convert';

import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/base/model/tuple_response.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:get/get.dart';

class ActivityRepository {
  final DioClient dioClient = Get.find();

  Future<void> getActivity(
      {String? id,
      required Function(Activity?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getActivities}$id",
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(ActivityWrapper.fromJson(value.data).activity),
          onError: onError,
        );
  }

  Future<void> createActivity(
      {Activity? activity,
      required Function(Activity?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.getActivities,
          body: jsonEncode(ActivityWrapper(activity: activity)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(ActivityWrapper.fromJson(value.data).activity),
          onError: onError,
        );
  }

  Future<void> getActivities(
      {QueryParams? queryParams,
      required Function(TupleResponse<List<Activity>?>) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getActivities,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(TupleResponse(
              data: ActivityWrapper.fromJson(value.data).activities,
              pages: value.pages,
              counts: value.counts)),
          onError: onError,
        );
  }
}
