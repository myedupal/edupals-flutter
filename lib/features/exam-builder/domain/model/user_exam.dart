import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';

class UserExamWrapper {
  UserExam? userExam;
  List<UserExam>? userExams;
  String? pages;

  UserExamWrapper({
    this.userExam,
    this.userExams,
    this.pages,
  });

  factory UserExamWrapper.fromJson(Map<String, dynamic> json) =>
      UserExamWrapper(
        userExam: json["user_exam"] == null
            ? null
            : UserExam.fromJson(json["user_exam"]),
        userExams: json["user_exams"] == null
            ? null
            : List<UserExam>.from(
                json["user_exams"].map((x) => UserExam.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "user_exam": userExam?.toJson(),
      };
}

class UserExam {
  String? id;
  String? title;
  bool? isPublic;
  String? nanoid;
  String? createdById;
  String? subjectId;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? createdBy;
  Subject? subject;
  List<UserExamQuestion>? userExamQuestions;
  List<UserExamQuestion>? userExamQuestionsAttributes;

  UserExam({
    this.id,
    this.title,
    this.isPublic,
    this.nanoid,
    this.createdById,
    this.subjectId,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.subject,
    this.userExamQuestions,
  });

  factory UserExam.fromJson(Map<String, dynamic> json) => UserExam(
        id: json["id"],
        title: json["title"],
        isPublic: json["is_public"],
        nanoid: json["nanoid"],
        createdById: json["created_by_id"],
        subjectId: json["subject_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"] == null
            ? null
            : User.fromJson(json["created_by"]),
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        userExamQuestions: json["user_exam_questions"] == null
            ? []
            : List<UserExamQuestion>.from(json["user_exam_questions"]!
                .map((x) => UserExamQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "is_public": isPublic,
        "subject_id": subjectId,
        "user_exam_questions_attributes": userExamQuestionsAttributes
            ?.map((data) => data.toAttribute())
            .toList()
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}

class UserExamQuestion {
  String? id;
  String? userExamId;
  String? questionId;
  String? createdAt;
  String? updatedAt;
  Question? question;
  bool? isDestroy;

  UserExamQuestion({
    this.id,
    this.userExamId,
    this.questionId,
    this.createdAt,
    this.updatedAt,
    this.question,
    this.isDestroy,
  });

  factory UserExamQuestion.fromJson(Map<String, dynamic> json) =>
      UserExamQuestion(
        id: json["id"],
        userExamId: json["user_exam_id"],
        questionId: json["question_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_exam_id": userExamId,
        "question_id": questionId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "question": question?.toJson(),
      };

  Map<String, dynamic> toAttribute() => {
        "question_id": questionId,
        "_destroy": isDestroy,
        "id": id,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
