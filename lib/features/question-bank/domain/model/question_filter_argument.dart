import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/features/question-bank/presentation/controller/question_filter_segment_controller.dart';

class QuestionFilterArgument {
  KeyValue? subject;
  String? revisionType;
  QuestionFilterType? questionFilterType;

  QuestionFilterArgument({
    this.subject,
    this.revisionType,
    this.questionFilterType,
  });
}
