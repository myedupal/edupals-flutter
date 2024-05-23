import 'package:edupals/core/base/model/query_params.dart';

class ChallengeArgument {
  String? pageTitle;
  String? subjectTitle;
  QueryParams? questionQueryParams;
  String? challengeId;

  ChallengeArgument({
    this.questionQueryParams,
    this.pageTitle,
    this.subjectTitle,
    this.challengeId,
  });
}
