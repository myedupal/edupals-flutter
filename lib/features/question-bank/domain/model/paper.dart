import 'package:edupals/features/question-bank/domain/model/subject.dart';

class Paper {
  String? id;
  String? name;
  String? subjectId;
  Subject? subject;
  List<dynamic>? exams;

  Paper({
    this.id,
    this.name,
    this.subjectId,
    this.subject,
    this.exams,
  });

  factory Paper.fromJson(Map<String, dynamic> json) => Paper(
        id: json["id"],
        name: json["name"],
        subjectId: json["subject_id"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        exams: json["exams"] == null
            ? []
            : List<dynamic>.from(json["exams"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subject_id": subjectId,
        "subject": subject?.toJson(),
        "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x)),
      };
}
