import 'package:edupals/core/base/model/query_params.dart';

class ChallengeArgument {
  String? title;
  QueryParams? questionQueryParams;
  String? challengeId;

  ChallengeArgument({
    this.questionQueryParams,
    this.title,
    this.challengeId,
  });
}
