import 'package:edupals/features/challenge/domain/model/challenge_question.dart';
import 'package:edupals/features/question-bank/domain/model/question.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';

class ChallengeWrapper {
  Challenge? challenge;
  List<Challenge>? challenges;
  String? pages;

  ChallengeWrapper({
    this.challenge,
    this.challenges,
    this.pages,
  });

  factory ChallengeWrapper.fromJson(Map<String, dynamic> json) =>
      ChallengeWrapper(
        challenge: json["challenge"] == null
            ? null
            : Challenge.fromJson(json["challenge"]),
        challenges: json["challenges"] == null
            ? null
            : List<Challenge>.from(
                json["challenges"].map((x) => Challenge.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "challenge": challenge?.toJson(),
      };
}

class Challenge {
  String? id;
  String? title;
  String? challengeType;
  String? startAt;
  String? endAt;
  int? rewardPoints;
  String? rewardType;
  int? penaltySeconds;
  String? subjectId;
  int? userSubmissionCount;
  int? userSuccessSubmissionCount;
  String? createdAt;
  String? updatedAt;
  Subject? subject;
  List<ChallengeQuestion>? challengeQuestions;
  List<Question>? questions;
  int? challengeQuestionsCount;

  Challenge({
    this.id,
    this.title,
    this.challengeType,
    this.startAt,
    this.endAt,
    this.rewardPoints,
    this.rewardType,
    this.penaltySeconds,
    this.subjectId,
    this.userSubmissionCount,
    this.userSuccessSubmissionCount,
    this.createdAt,
    this.updatedAt,
    this.subject,
    this.challengeQuestions,
    this.questions,
    this.challengeQuestionsCount,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        id: json["id"],
        title: json["title"],
        challengeType: json["challenge_type"],
        startAt: json["start_at"],
        endAt: json["end_at"],
        rewardPoints: json["reward_points"],
        rewardType: json["reward_type"],
        penaltySeconds: json["penalty_seconds"],
        subjectId: json["subject_id"],
        userSubmissionCount: json["user_submission_count"],
        userSuccessSubmissionCount: json["user_success_submission_count"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        challengeQuestions: json["challenge_questions"] == null
            ? []
            : List<ChallengeQuestion>.from(json["challenge_questions"]
                .map((x) => ChallengeQuestion.fromJson(x))),
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
        challengeQuestionsCount: json["challenge_questions_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "challenge_type": challengeType,
        "start_at": startAt,
        "end_at": endAt,
        "reward_points": rewardPoints,
        "reward_type": rewardType,
        "penalty_seconds": penaltySeconds,
        "subject_id": subjectId,
        "user_submission_count": userSubmissionCount,
        "user_success_submission_count": userSuccessSubmissionCount,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "subject": subject?.toJson(),
        "challenge_questions": challengeQuestions == null
            ? []
            : List<dynamic>.from(challengeQuestions!.map((x) => x.toJson())),
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
