import 'dart:convert';

import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/base/model/tuple_response.dart';
import 'package:edupals/core/extensions/api_extensions.dart';
import 'package:edupals/core/network/dio_client.dart';
import 'package:edupals/core/network/errors/failures.dart';
import 'package:edupals/core/values/api_constants.dart';
import 'package:edupals/features/exam-builder/domain/model/user_exam.dart';
import 'package:get/get.dart';

class UserExamRepository {
  final DioClient dioClient = Get.find();

  Future<void> getUserExams(
      {QueryParams? queryParams,
      required Function(TupleResponse<List<UserExam>?>) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          ApiConstants.getUserExams,
          queryParameters: queryParams?.toJson(),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(TupleResponse(
              data: UserExamWrapper.fromJson(value.data).userExams,
              pages: value.pages,
              counts: value.counts)),
          onError: onError,
        );
  }

  Future<void> getUserExam(
      {required String id,
      required Function(UserExam?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .get(
          "${ApiConstants.getUserExams}$id",
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(UserExamWrapper.fromJson(value.data).userExam),
          onError: onError,
        );
  }

  Future<void> createUserExam(
      {UserExam? userExam,
      required Function(UserExam?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.getUserExams,
          body: jsonEncode(UserExamWrapper(userExam: userExam)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(UserExamWrapper.fromJson(value.data).userExam),
          onError: onError,
        );
  }

  Future<void> updateUserExam(
      {UserExam? userExam,
      required String id,
      required Function(UserExam?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .put(
          "${ApiConstants.getUserExams}$id",
          body: jsonEncode(UserExamWrapper(userExam: userExam)),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) =>
              onSuccess.call(UserExamWrapper.fromJson(value.data).userExam),
          onError: onError,
        );
  }
}
