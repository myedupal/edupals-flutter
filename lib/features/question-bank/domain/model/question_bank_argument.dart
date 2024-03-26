import 'package:edupals/core/base/model/query_params.dart';

class QuestionBankArgument {
  String? title;
  bool isHistory;
  String? revisionType;
  List<String>? titleList;
  QueryParams? queryParams;

  QuestionBankArgument({
    this.queryParams,
    this.isHistory = false,
    this.title,
    this.revisionType,
    this.titleList,
  });
}
