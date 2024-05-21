class DashboardReport {
  String? averageTime;
  int? dailyStreak;
  int? totalCorrectQuestions;
  int? totalQuestionsAttempted;
  String? strengthSubject;
  String? weaknessSubject;

  DashboardReport({
    this.averageTime,
    this.dailyStreak,
    this.totalCorrectQuestions,
    this.totalQuestionsAttempted,
    this.strengthSubject,
    this.weaknessSubject,
  });

  String? get getTotalCorrectQuestions =>
      totalCorrectQuestions == 0 && totalQuestionsAttempted == 0
          ? "0"
          : "$totalCorrectQuestions / $totalQuestionsAttempted";

  String? get getParsedAverageTime {
    final convertedSeconds = (double.tryParse(averageTime ?? "0") ?? 0).round();
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

  factory DashboardReport.fromJson(Map<String, dynamic> json) =>
      DashboardReport(
        averageTime: json["average_time"],
        dailyStreak: json["daily_streak"],
        totalCorrectQuestions: json["total_correct_questions"],
        totalQuestionsAttempted: json["total_questions_attempted"],
        strengthSubject: json["strength_subject"] == "Not enough data"
            ? "N/A"
            : json["strength_subject"],
        weaknessSubject: json["weakness_subject"] == "Not enough data"
            ? "N/A"
            : json["weakness_subject"],
      );

  Map<String, dynamic> toJson() => {
        "average_time": averageTime,
        "daily_streak": dailyStreak,
        "total_correct_questions": totalCorrectQuestions,
        "total_questions_attempted": totalQuestionsAttempted,
        "strength_subject": strengthSubject,
        "weakness_subject": weaknessSubject,
      };
}
