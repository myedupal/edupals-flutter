import 'package:edupals/features/question-bank/domain/model/question.dart';

class SubmissionAnswerWrapper {
  SubmissionAnswer? submissionAnswer;
  List<SubmissionAnswer>? submissionAnswers;
  String? pages;

  SubmissionAnswerWrapper({
    this.submissionAnswer,
    this.submissionAnswers,
    this.pages,
  });

  factory SubmissionAnswerWrapper.fromJson(Map<String, dynamic> json) =>
      SubmissionAnswerWrapper(
        submissionAnswer: json["submission_answer"] == null
            ? null
            : SubmissionAnswer.fromJson(json["submission_answer"]),
        submissionAnswers: json["submission_answers"] == null
            ? null
            : List<SubmissionAnswer>.from(json["submission_answers"]
                .map((x) => SubmissionAnswer.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "submission_answer": submissionAnswer?.toJson(),
      };
}

class SubmissionAnswer {
  String? id;
  String? answer;
  bool? isCorrect;
  int? score;
  String? challengeSubmissionId;
  String? questionId;
  String? userId;
  String? evaluatedAt;
  String? createdAt;
  String? updatedAt;
  dynamic challengeSubmission;
  Question? question;

  SubmissionAnswer({
    this.id,
    this.answer,
    this.isCorrect,
    this.score,
    this.challengeSubmissionId,
    this.questionId,
    this.userId,
    this.evaluatedAt,
    this.createdAt,
    this.updatedAt,
    this.challengeSubmission,
    this.question,
  });

  factory SubmissionAnswer.fromJson(Map<String, dynamic> json) =>
      SubmissionAnswer(
        id: json["id"],
        answer: json["answer"],
        isCorrect: json["is_correct"],
        score: json["score"],
        challengeSubmissionId: json["challenge_submission_id"],
        questionId: json["question_id"],
        userId: json["user_id"],
        evaluatedAt: json["evaluated_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        // challengeSubmission: json["challenge_submission"],
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "challenge_submission_id": challengeSubmissionId,
        "question_id": questionId,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
