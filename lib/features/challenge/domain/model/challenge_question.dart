class ChallengeQuestion {
  String? id;
  String? challengeId;
  String? questionId;
  int? displayOrder;
  int? score;
  String? createdAt;
  String? updatedAt;

  ChallengeQuestion({
    this.id,
    this.challengeId,
    this.questionId,
    this.displayOrder,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  factory ChallengeQuestion.fromJson(Map<String, dynamic> json) =>
      ChallengeQuestion(
        id: json["id"],
        challengeId: json["challenge_id"],
        questionId: json["question_id"],
        displayOrder: json["display_order"],
        score: json["score"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "challenge_id": challengeId,
        "question_id": questionId,
        "display_order": displayOrder,
        "score": score,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
