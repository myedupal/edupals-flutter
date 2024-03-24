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
    this.season,
    this.subjectId,
    this.topicId,
    this.year,
    this.zone,
    this.curriculumId,
    this.fromStartAt,
    this.toStartAt,
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
  List<String>? examId;
  String? zone;
  String? season;
  List<String>? year;
  bool? active;
  bool? isActive;
  String? curriculumId;
  String? fromStartAt;
  String? toStartAt;

  factory QueryParams.fromJson(Map<String, dynamic> json) => QueryParams(
        page: int.parse(json["page"] ?? "1"),
        items: int.parse(json["items"] ?? "100"),
        sortBy: json["sort_by"],
        sortOrder: json["sort_order"],
        subjectId: json["subject_id"],
        examId: json["exam_id"],
        zone: json["zone"],
        season: json["season"],
        year: json["year"],
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
        "exam_id[]": examId?.isNotEmpty == true ? examId : null,
        "topic_id[]": topicId?.isNotEmpty == true ? topicId : null,
        "year[]": year?.isNotEmpty == true ? year : null,
        "subject_id": subjectId,
        "season": season,
        "zone": zone,
        "curriculum_id": curriculumId,
        "from_start_at": fromStartAt,
        "to_start_at": toStartAt,
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");

  Map<String, dynamic> toMetadata() => {
        "page": page.toString(),
        "items": items.toString(),
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "years": year?.isNotEmpty == true ? year : null,
        "seasons": season?.isNotEmpty == true ? [season] : null,
        "zones": season?.isNotEmpty == true ? [zone] : null,
        "curriculum_id": curriculumId
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
