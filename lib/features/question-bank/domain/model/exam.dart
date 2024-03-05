import 'package:edupals/core/base/model/file_url.dart';
import 'package:edupals/features/question-bank/domain/model/paper.dart';

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
