import 'package:edupals/core/base/model/query_params.dart';
import 'package:edupals/core/base/model/table_column.dart';
import 'package:edupals/core/network/utils/formatter.dart';
import 'package:edupals/features/question-bank/domain/model/exam.dart';
import 'package:edupals/features/question-bank/domain/model/paper.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';

class ActivityWrapper {
  Activity? activity;
  List<Activity>? activities;
  String? pages;

  ActivityWrapper({
    this.activity,
    this.activities,
    this.pages,
  });

  factory ActivityWrapper.fromJson(Map<String, dynamic> json) =>
      ActivityWrapper(
        activity: json["activity"] == null
            ? null
            : Activity.fromJson(json["activity"]),
        activities: json["activities"] == null
            ? null
            : List<Activity>.from(
                json["activities"].map((x) => Activity.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "activity": activity?.toJson(),
      };
}

class Activity extends TableConvertible {
  String? id;
  String? activityType;
  int? activityQuestionsCount;
  String? userId;
  String? subjectId;
  String? examId;
  QueryParams? metadata;
  List<String>? topicIds;
  List<String>? paperIds;
  int? questionsCount;
  String? createdAt;
  String? updatedAt;
  Subject? subject;
  Exam? exam;
  List<Paper>? papers;
  List<Topic>? topics;

  Activity({
    this.id,
    this.activityType,
    this.activityQuestionsCount,
    this.userId,
    this.subjectId,
    this.examId,
    this.metadata,
    this.topicIds,
    this.paperIds,
    this.questionsCount,
    this.createdAt,
    this.updatedAt,
    this.subject,
    this.exam,
    this.papers,
    this.topics,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        activityType: json["activity_type"],
        activityQuestionsCount: json["activity_questions_count"],
        userId: json["user_id"],
        subjectId: json["subject_id"],
        examId: json["exam_id"],
        metadata: json["metadata"] == null
            ? null
            : QueryParams.fromJson(json["metadata"]),
        topicIds: json["topic_ids"] == null
            ? []
            : List<String>.from(json["topic_ids"]!.map((x) => x)),
        paperIds: json["paper_ids"] == null
            ? []
            : List<String>.from(json["paper_ids"]!.map((x) => x)),
        questionsCount: json["questions_count"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
        papers: json["papers"] == null
            ? []
            : List<Paper>.from(json["papers"]!.map((x) => Paper.fromJson(x))),
        topics: json["topics"] == null
            ? []
            : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "activity_type": activityType,
        "subject_id": subjectId,
        "exam_id": examId,
        "metadata": metadata?.toMetadata(),
        "topic_ids": topicIds,
        "paper_ids": paperIds,
      };

  @override
  Map<String, dynamic> toTable() => {
        "activity_type": activityType,
        "activity_questions_count": activityQuestionsCount,
        "created_at": createdAt?.formatDateString(pattern: "dd MMM yyyy"),
      };
}
