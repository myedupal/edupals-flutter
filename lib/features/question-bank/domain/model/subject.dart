import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/features/dashboard/domain/model/curriculum.dart';
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
  ExamsFilteringWrapper? examsFiltering;
  Curriculum? curriculum;
  List<Paper>? papers;

  Subject({
    this.id,
    this.name,
    this.code,
    this.curriculumId,
    this.curriculum,
    this.examsFiltering,
    this.papers,
  });

  String? get getBackgroundImage {
    return AppAssets()
        .getPngPath(name: "${name?.replaceAll(" ", "_").toLowerCase()}_bg");
  }

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        curriculumId: json["curriculum_id"],
        curriculum: json["curriculum"] == null
            ? null
            : Curriculum.fromJson(json["curriculum"]),
        examsFiltering: json["exams_filtering"] == null
            ? null
            : ExamsFilteringWrapper.fromJson(json["exams_filtering"]),
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

class ExamsFilteringWrapper {
  ExamsFiltering? all;
  ExamsFiltering? mcq;

  ExamsFilteringWrapper({
    this.all,
    this.mcq,
  });

  factory ExamsFilteringWrapper.fromJson(Map<String, dynamic> json) =>
      ExamsFilteringWrapper(
        all: json["all"] == null ? null : ExamsFiltering.fromJson(json["all"]),
        mcq: json["mcq"] == null ? null : ExamsFiltering.fromJson(json["mcq"]),
      );

  Map<String, dynamic> toJson() => {
        "all": all?.toJson(),
        "mcq": mcq?.toJson(),
      };
}

class ExamsFiltering {
  List<String>? papers;
  List<String>? zones;
  List<String>? seasons;
  List<int>? years;
  List<dynamic>? levels;

  ExamsFiltering({
    this.papers,
    this.zones,
    this.seasons,
    this.years,
    this.levels,
  });

  factory ExamsFiltering.fromJson(Map<String, dynamic> json) => ExamsFiltering(
        papers: json["papers"] == null
            ? []
            : List<String>.from(json["papers"]!.map((x) => x)),
        zones: json["zones"] == null
            ? []
            : List<String>.from(json["zones"]!.map((x) => x)),
        seasons: json["seasons"] == null
            ? []
            : List<String>.from(json["seasons"]!.map((x) => x)),
        years: json["years"] == null
            ? []
            : List<int>.from(json["years"]!.map((x) => x)),
        levels: json["levels"] == null
            ? []
            : List<dynamic>.from(json["levels"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "papers":
            papers == null ? [] : List<dynamic>.from(papers!.map((x) => x)),
        "zones": zones == null ? [] : List<dynamic>.from(zones!.map((x) => x)),
        "seasons":
            seasons == null ? [] : List<dynamic>.from(seasons!.map((x) => x)),
        "years": years == null ? [] : List<dynamic>.from(years!.map((x) => x)),
        "levels":
            levels == null ? [] : List<dynamic>.from(levels!.map((x) => x)),
      };
}
