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
