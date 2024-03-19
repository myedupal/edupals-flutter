import 'package:edupals/core/base/model/query_params.dart';

class QuestionBankArgument {
  String? title;
  String? revisionType;
  List<String>? titleList;
  QueryParams? queryParams;

  QuestionBankArgument(
      {this.queryParams, this.title, this.revisionType, this.titleList});
}
