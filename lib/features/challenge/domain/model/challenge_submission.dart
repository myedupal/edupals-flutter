import 'package:edupals/features/challenge/domain/model/challenge.dart';
import 'package:edupals/features/challenge/domain/model/submission_answer.dart';
import 'package:get/get.dart';

class ChallengeSubmissionWrapper {
  ChallengeSubmission? challengeSubmission;
  List<ChallengeSubmission>? challengeSubmissions;

  ChallengeSubmissionWrapper({
    this.challengeSubmission,
    this.challengeSubmissions,
  });

  factory ChallengeSubmissionWrapper.fromJson(Map<String, dynamic> json) =>
      ChallengeSubmissionWrapper(
        challengeSubmission: json["submission"] == null
            ? null
            : ChallengeSubmission.fromJson(json["submission"]),
        challengeSubmissions: json["submissions"] == null
            ? null
            : List<ChallengeSubmission>.from(json["submissions"]
                .map((x) => ChallengeSubmission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "submission": challengeSubmission?.toJson(),
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
  String? title;
  Challenge? challenge;
  List<SubmissionAnswersAttribute>? submissionAnswersAttributes;
  List<SubmissionAnswer>? submissionAnswers;
  int? totalSubmittedAnswers;
  int? totalCorrectQuestions;

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
    this.title,
    this.challenge,
    this.submissionAnswersAttributes,
    this.submissionAnswers,
    this.totalCorrectQuestions,
    this.totalSubmittedAnswers,
  });

  String? get getParsedTime {
    final convertedSeconds = completionSeconds?.round() ?? 0;
    int hours = convertedSeconds ~/ 3600;
    int minutes = (convertedSeconds % 3600) ~/ 60;
    int remainingSeconds = convertedSeconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m ${remainingSeconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${remainingSeconds}s';
    } else {
      return '${remainingSeconds}s';
    }
  }

  int? get totalWrongAnswers {
    return (totalSubmittedAnswers ?? 0) - (totalCorrectQuestions ?? 0);
  }

  String? get getYear {
    return title
        ?.split("|")
        .firstWhereOrNull((element) => element.contains("Year"));
  }

  String? get getZone {
    return title
        ?.split("|")
        .firstWhereOrNull((element) => element.contains("Zone"));
  }

  String? get getSeason {
    return title
        ?.split("|")
        .firstWhereOrNull((element) => element.contains("Season"));
  }

  String? get getPaper {
    return title
        ?.split("|")
        .firstWhereOrNull((element) => element.contains("Paper"));
  }

  String? get getSubject {
    return title?.split("|").firstWhereOrNull((element) => ![
          "Season",
          "Paper",
          "Zone",
          "Year",
          "Yearly",
          "Topical"
        ].contains(element));
  }

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
        title: json["title"],
        challenge: json["challenge"] == null
            ? null
            : Challenge.fromJson(json["challenge"]),
        submissionAnswersAttributes:
            json["submission_answers_attributes"] == null
                ? []
                : List<SubmissionAnswersAttribute>.from(
                    json["submission_answers_attributes"]!
                        .map((x) => SubmissionAnswersAttribute.fromJson(x))),
        submissionAnswers: json["submission_answers"] == null
            ? []
            : List<SubmissionAnswer>.from(json["submission_answers"]!
                .map((x) => SubmissionAnswer.fromJson(x))),
        totalCorrectQuestions: json["total_correct_answers"],
        totalSubmittedAnswers: json["total_submitted_answers"],
      );

  Map<String, dynamic> toJson() => {
        "challenge_id": challengeId,
        "title": title,
        "submission_answers_attributes": submissionAnswersAttributes == null
            ? []
            : List<SubmissionAnswersAttribute>.from(
                submissionAnswersAttributes!.map((x) => x.toJson())),
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
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
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
