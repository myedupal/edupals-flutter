class QueryParams {
  QueryParams({
    this.page,
    this.items,
    this.active,
    this.sortBy,
    this.sortOrder,
    this.status,
    this.query,
    this.fromDate,
    this.toDate,
    this.isActive,
    this.examId,
    this.paperId,
    this.paperName,
    this.season,
    this.subjectId,
    this.topicId,
    this.year,
    this.zone,
    this.curriculumId,
    this.fromStartAt,
    this.toStartAt,
    this.challengeId,
    this.challengeSubmissionId,
    this.hasMcqQuestions,
  });

  int? page;
  int? items;
  String? sortBy;
  String? sortOrder;
  dynamic status;
  String? query;
  String? fromDate;
  String? toDate;
  List<String>? topicId;
  String? subjectId;
  String? paperId;
  String? paperName;
  List<String>? examId;
  List<String>? zone;
  List<String>? season;
  List<String>? year;
  bool? active;
  bool? isActive;
  String? curriculumId;
  String? fromStartAt;
  String? toStartAt;
  String? challengeId;
  String? challengeSubmissionId;
  bool? hasMcqQuestions;

  factory QueryParams.fromJson(Map<String, dynamic> json) => QueryParams(
        page: int.parse(json["page"] ?? "1"),
        items: int.parse(json["items"] ?? "100"),
        sortBy: json["sort_by"],
        sortOrder: json["sort_order"],
        subjectId: json["subject_id"],
        examId: json["exam_id"],
        zone: json["zone"] ?? json["zones"] != null
            ? (List<String>.from(json["zones"]!.map((e) => e.toString())))
            : null,
        season: json["season"] ?? json["seasons"] != null
            ? (List<String>.from(json["seasons"]!.map((e) => e.toString())))
            : null,
        year: json["year"] ?? json["years"] != null
            ? (List<String>.from(json["years"]!.map((e) => e.toString())))
            : null,
        fromStartAt: json["from_start_at"],
        toStartAt: json["to_start_at"],
      );

  Map<String, dynamic> toJson() => {
        "page": page.toString(),
        "items": items.toString(),
        "active": active.toString(),
        "is_active": isActive.toString(),
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "status[]": status?.isNotEmpty == true ? status : null,
        "query": query,
        "from_date": fromDate,
        "to_date": toDate,
        // Question List
        "paper_id": paperId,
        "paper_name": paperName,
        "exam_id[]": examId?.isNotEmpty == true ? examId : null,
        "topic_id[]": topicId?.isNotEmpty == true ? topicId : null,
        "year[]": year?.isNotEmpty == true ? year : null,
        "subject_id": subjectId,
        "season[]": season,
        "zone[]": zone,
        "curriculum_id": curriculumId,
        "from_start_at": fromStartAt,
        "to_start_at": toStartAt,
        "challenge_id": challengeId,
        "submission_id": challengeSubmissionId,
        "has_mcq_questions": hasMcqQuestions,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");

  Map<String, dynamic> toMetadata() => {
        "page": page.toString(),
        "items": items.toString(),
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "years": year?.isNotEmpty == true ? year : null,
        "seasons": season?.isNotEmpty == true ? season : null,
        "zones": season?.isNotEmpty == true ? zone : null,
        "curriculum_id": curriculumId
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
