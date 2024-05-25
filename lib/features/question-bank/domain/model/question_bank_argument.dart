import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/features/history/domain/model/activity.dart';

class QuestionBankArgument {
  String? title;
  bool isHistory;
  String? revisionType;
  KeyValue? subject;
  String? paper;
  // List<String>? titleList;
  QueryParams? queryParams;
  Activity? activity;
  String? userExamId;

  QuestionBankArgument({
    this.queryParams,
    this.isHistory = false,
    this.title,
    this.revisionType,
    this.subject,
    this.paper,
    // this.titleList,
    this.activity,
    this.userExamId,
  });
}
