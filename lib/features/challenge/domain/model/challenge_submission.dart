import 'package:edupals/features/challenge/domain/model/challenge.dart';

class ChallengeSubmissionWrapper {
  ChallengeSubmission? challengeSubmission;

  ChallengeSubmissionWrapper({
    this.challengeSubmission,
  });

  factory ChallengeSubmissionWrapper.fromJson(Map<String, dynamic> json) =>
      ChallengeSubmissionWrapper(
        challengeSubmission: json["challenge_submission"] == null
            ? null
            : ChallengeSubmission.fromJson(json["challenge_submission"]),
      );

  Map<String, dynamic> toJson() => {
        "challenge_submission": challengeSubmission?.toJson(),
      };
}

class ChallengeSubmission {
  String? id;
  String? status;
  int? score;
  int? totalScore;
  int? completionSeconds;
  int? penaltySeconds;
  String? submittedAt;
  String? challengeId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Challenge? challenge;
  List<SubmissionAnswersAttribute>? submissionAnswersAttributes;

  ChallengeSubmission({
    this.id,
    this.status,
    this.score,
    this.totalScore,
    this.completionSeconds,
    this.penaltySeconds,
    this.submittedAt,
    this.challengeId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.challenge,
    this.submissionAnswersAttributes,
  });

  factory ChallengeSubmission.fromJson(Map<String, dynamic> json) =>
      ChallengeSubmission(
        id: json["id"],
        status: json["status"],
        score: json["score"],
        totalScore: json["total_score"],
        completionSeconds: json["completion_seconds"],
        penaltySeconds: json["penalty_seconds"],
        submittedAt: json["submitted_at"],
        challengeId: json["challenge_id"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        challenge: json["challenge"] == null
            ? null
            : Challenge.fromJson(json["challenge"]),
        submissionAnswersAttributes:
            json["submission_answers_attributes"] == null
                ? []
                : List<SubmissionAnswersAttribute>.from(
                    json["submission_answers_attributes"]!
                        .map((x) => SubmissionAnswersAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "challenge_id": challengeId,
        "submission_answers_attributes": submissionAnswersAttributes == null
            ? []
            : List<SubmissionAnswersAttribute>.from(
                submissionAnswersAttributes!.map((x) => x.toJson())),
      };
}

class SubmissionAnswersAttribute {
  String? questionId;
  String? answer;

  SubmissionAnswersAttribute({
    this.questionId,
    this.answer,
  });

  factory SubmissionAnswersAttribute.fromJson(Map<String, dynamic> json) =>
      SubmissionAnswersAttribute(
        questionId: json["question_id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "answer": answer,
      };
}