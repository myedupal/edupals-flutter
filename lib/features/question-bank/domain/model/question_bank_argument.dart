import 'package:edupals/core/base/model/query_params.dart';

class QuestionBankArgument {
  String? title;
  List<String>? titleList;
  QueryParams? queryParams;

  QuestionBankArgument({this.queryParams, this.title, this.titleList});
}
