import 'package:edupals/features/history/domain/model/activity.dart';

class ActivityQuestionWrapper {
  ActivityQuestion? activityQuestion;
  List<ActivityQuestion>? activityQuestions;
  String? pages;

  ActivityQuestionWrapper({
    this.activityQuestion,
    this.activityQuestions,
    this.pages,
  });

  factory ActivityQuestionWrapper.fromJson(Map<String, dynamic> json) =>
      ActivityQuestionWrapper(
        activityQuestion: json["activity_question"] == null
            ? null
            : ActivityQuestion.fromJson(json["activity_question"]),
        activityQuestions: json["activity_questions"] == null
            ? null
            : List<ActivityQuestion>.from(json["activity_questions"]
                .map((x) => ActivityQuestion.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "activity_question": activityQuestion?.toJson(),
      };
}

class ActivityQuestion {
  String? id;
  String? activityId;
  String? questionId;
  Activity? activity;
  String? createdAt;
  String? updatedAt;

  ActivityQuestion({
    this.id,
    this.activityId,
    this.questionId,
    this.activity,
    this.createdAt,
    this.updatedAt,
  });

  factory ActivityQuestion.fromJson(Map<String, dynamic> json) =>
      ActivityQuestion(
        id: json["id"],
        activityId: json["activity_id"],
        activity: json["activity"] != null
            ? Activity.fromJson(json["activity"])
            : null,
        questionId: json["question_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activity_id": activityId,
        "question_id": questionId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
