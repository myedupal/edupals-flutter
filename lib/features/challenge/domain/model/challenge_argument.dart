import 'package:edupals/core/base/model/query_params.dart';

class ChallengeArgument {
  String? mainTitle;
  String? subjectTitle;
  QueryParams? questionQueryParams;
  String? challengeId;

  ChallengeArgument({
    this.questionQueryParams,
    this.mainTitle,
    this.subjectTitle,
    this.challengeId,
  });
}
