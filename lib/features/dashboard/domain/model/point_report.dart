class PointReport {
  int? totalPoints;
  int? mcqPoints;
  int? dailyChallengePoints;
  int? dailyCheckInPoints;

  PointReport({
    this.totalPoints,
    this.mcqPoints,
    this.dailyChallengePoints,
    this.dailyCheckInPoints,
  });

  factory PointReport.fromJson(Map<String, dynamic> json) => PointReport(
        totalPoints: json["total_points"],
        mcqPoints: json["mcq_points"],
        dailyChallengePoints: json["daily_challenge_points"],
        dailyCheckInPoints: json["daily_check_in_points"],
      );

  Map<String, dynamic> toJson() => {
        "total_points": totalPoints,
        "mcq_points": mcqPoints,
        "daily_challenge_points": dailyChallengePoints,
        "daily_check_in_points": dailyCheckInPoints,
      };
}
