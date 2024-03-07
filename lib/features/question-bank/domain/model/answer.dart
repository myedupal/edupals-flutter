import 'package:edupals/core/base/model/file_url.dart';

class Answer {
  String? id;
  String? text;
  FileUrl? image;
  String? questionId;
  int? displayOrder;
  String? createdAt;
  String? updatedAt;

  Answer({
    this.id,
    this.text,
    this.image,
    this.questionId,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        text: json["text"],
        image: json["image"] == null ? null : FileUrl.fromJson(json["image"]),
        questionId: json["question_id"],
        displayOrder: json["display_order"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "image": image?.toJson(),
        "question_id": questionId,
        "display_order": displayOrder,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
