class Topic {
  String? id;
  String? name;
  String? subjectId;

  Topic({
    this.id,
    this.name,
    this.subjectId,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        subjectId: json["subject_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subject_id": subjectId,
      };
}
