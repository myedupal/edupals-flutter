import 'package:edupals/features/question-bank/domain/model/curriculum.dart';
import 'package:edupals/features/question-bank/domain/model/paper.dart';

class SubjectWrapper {
  Subject? subject;
  List<Subject>? subjects;
  String? pages;

  SubjectWrapper({
    this.subject,
    this.subjects,
    this.pages,
  });

  factory SubjectWrapper.fromJson(Map<String, dynamic> json) => SubjectWrapper(
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        subjects: json["subjects"] == null
            ? null
            : List<Subject>.from(
                json["subjects"].map((x) => Subject.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject?.toJson(),
      };
}

class Subject {
  String? id;
  String? name;
  String? code;
  String? curriculumId;
  Curriculum? curriculum;
  List<Paper>? papers;

  Subject({
    this.id,
    this.name,
    this.code,
    this.curriculumId,
    this.curriculum,
    this.papers,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        curriculumId: json["curriculum_id"],
        curriculum: json["curriculum"] == null
            ? null
            : Curriculum.fromJson(json["curriculum"]),
        papers: json["papers"] == null
            ? []
            : List<Paper>.from(json["papers"]!.map((x) => Paper.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "curriculum_id": curriculumId,
        "curriculum": curriculum?.toJson(),
        "papers": papers == null
            ? []
            : List<dynamic>.from(papers!.map((x) => x.toJson())),
      };
}
