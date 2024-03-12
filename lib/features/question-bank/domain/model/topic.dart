class TopicWrapper {
  Topic? topic;
  List<Topic>? topics;
  String? pages;

  TopicWrapper({
    this.topic,
    this.topics,
    this.pages,
  });

  factory TopicWrapper.fromJson(Map<String, dynamic> json) => TopicWrapper(
        topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
        topics: json["topics"] == null
            ? null
            : List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "topic": topic?.toJson(),
      };
}

class Topic {
  String? id;
  String? name;
  String? subjectId;

  Topic({
    this.id,
    this.name,
    this.subjectId,
  });

  String? get getChapter {
    int hyphenIndex = name?.indexOf('-') ?? -1;
    if (hyphenIndex != -1) {
      String chNumber = name?.substring(0, hyphenIndex).trim() ?? "";
      return chNumber;
    } else {
      return "";
    }
  }

  String? get getShortName {
    int hyphenIndex = name?.indexOf('-') ?? -1;
    if (hyphenIndex != -1) {
      String chapterName = name?.substring(hyphenIndex + 1).trim() ?? "";
      return chapterName;
    } else {
      return "";
    }
  }

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