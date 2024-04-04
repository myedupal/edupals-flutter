import 'package:edupals/core/base/model/file_url.dart';
import 'package:edupals/features/question-bank/domain/model/paper.dart';

class ExamWrapper {
  Exam? exam;
  List<Exam>? exams;
  String? pages;

  ExamWrapper({
    this.exam,
    this.exams,
    this.pages,
  });

  factory ExamWrapper.fromJson(Map<String, dynamic> json) => ExamWrapper(
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
        exams: json["exams"] == null
            ? null
            : List<Exam>.from(json["exams"].map((x) => Exam.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "exam": exam?.toJson(),
      };
}

class Exam {
  String? id;
  int? year;
  String? season;
  String? zone;
  dynamic level;
  FileUrl? file;
  FileUrl? markingScheme;
  String? paperId;
  Paper? paper;

  Exam({
    this.id,
    this.year,
    this.season,
    this.zone,
    this.level,
    this.file,
    this.markingScheme,
    this.paperId,
    this.paper,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        year: json["year"],
        season: json["season"],
        zone: json["zone"],
        level: json["level"],
        file: json["file"] == null ? null : FileUrl.fromJson(json["file"]),
        markingScheme: json["marking_scheme"] == null
            ? null
            : FileUrl.fromJson(json["marking_scheme"]),
        paperId: json["paper_id"],
        paper: json["paper"] == null ? null : Paper.fromJson(json["paper"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "season": season,
        "zone": zone,
        "level": level,
        "file": file?.toJson(),
        "marking_scheme": markingScheme?.toJson(),
        "paper_id": paperId,
        "paper": paper?.toJson(),
      };
}
