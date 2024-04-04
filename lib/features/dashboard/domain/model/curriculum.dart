class CurriculumWrapper {
  Curriculum? curriculum;
  List<Curriculum>? curriculums;
  String? pages;

  CurriculumWrapper({
    this.curriculum,
    this.curriculums,
    this.pages,
  });

  factory CurriculumWrapper.fromJson(Map<String, dynamic> json) =>
      CurriculumWrapper(
        curriculum: json["curriculum"] == null
            ? null
            : Curriculum.fromJson(json["curriculum"]),
        curriculums: json["curriculums"] == null
            ? null
            : List<Curriculum>.from(
                json["curriculums"].map((x) => Curriculum.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "curriculum": curriculum?.toJson(),
      };
}

class Curriculum {
  String? id;
  String? name;
  String? board;
  int? displayOrder;

  Curriculum({
    this.id,
    this.name,
    this.board,
    this.displayOrder,
  });

  String get getFullName => "$board $name";

  factory Curriculum.fromJson(Map<String, dynamic> json) => Curriculum(
        id: json["id"],
        name: json["name"],
        board: json["board"],
        displayOrder: json["display_order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "board": board,
        "display_order": displayOrder,
      };
}
