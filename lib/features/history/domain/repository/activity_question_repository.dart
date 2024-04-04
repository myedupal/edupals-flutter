import 'dart:convert';

import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/history/domain/model/activity_question.dart';
import 'package:get/get.dart';

class ActivityQuestionRepository {
  final DioClient dioClient = Get.find();

  Future<void> createActivityQuestion(
      {ActivityQuestion? activityQuestion,
      required Function(ActivityQuestion?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.getActivityQuestions,
          body: jsonEncode(
              ActivityQuestionWrapper(activityQuestion: activityQuestion)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(
              ActivityQuestionWrapper.fromJson(value.data).activityQuestion),
          onError: onError,
        );
  }
}
