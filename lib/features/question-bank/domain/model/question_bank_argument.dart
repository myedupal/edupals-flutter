import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/history/domain/model/activity.dart';

class QuestionBankArgument {
  String? title;
  bool isHistory;
  String? revisionType;
  // List<String>? titleList;
  QueryParams? queryParams;
  Activity? activity;
  String? userExamId;

  QuestionBankArgument({
    this.queryParams,
    this.isHistory = false,
    this.title,
    this.revisionType,
    // this.titleList,
    this.activity,
    this.userExamId,
  });
}
