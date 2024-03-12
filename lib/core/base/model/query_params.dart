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
        "exam_id[]": examId?.isNotEmpty == true ? examId : null,
        "topic_id[]": topicId?.isNotEmpty == true ? topicId : null,
        "year[]": year?.isNotEmpty == true ? year : null,
        "subject_id": subjectId,
        "season": season,
        "zone": zone,
        "curriculum_id": curriculumId
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
