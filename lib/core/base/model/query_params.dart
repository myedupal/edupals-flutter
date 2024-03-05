class QueryParams {
  QueryParams(
      {this.page,
      this.items,
      this.active,
      this.sortBy,
      this.sortOrder,
      this.status,
      this.clientId,
      this.approvalId,
      this.facilityId,
      this.buildingId,
      this.floorId,
      this.unitId,
      this.slotId,
      this.locateableType,
      this.query,
      this.runningNumber,
      this.approvalNumber,
      this.agreementId,
      this.locationType,
      this.interval,
      this.workPermitExpiryIn,
      this.passportPermitExpiryIn,
      this.hasActiveTenancy,
      this.pendingTenancy,
      this.hasPostEnrollment,
      this.enrollmentId,
      this.issueType,
      this.isVerified,
      this.hasAgreement,
      this.hasNoReplacingCallingVisa,
      this.isReplacement,
      this.isReplacementVisa,
      this.country,
      this.callingVisaId,
      this.workerIds,
      this.workerId,
      this.withSlot,
      this.postEnrollmentId,
      this.itemType,
      this.itemId,
      this.condition,
      this.isStayingOutside,
      this.facilityType,
      this.workerStatus,
      this.withActiveTenancy,
      this.latestVersion,
      this.expiryIn,
      this.enrollmentsFrom,
      this.fromDate,
      this.toDate,
      this.assigneeId,
      this.underLocatableId,
      this.attestationId,
      this.workPermitMissionType,
      this.isActive,
      this.locationId,
      this.notificationType,
      this.department,
      this.hasWorkOrder,
      this.exportHeaders});

  int? page;
  int? items;
  String? sortBy;
  String? sortOrder;
  dynamic status;
  String? clientId;
  String? approvalId;
  String? facilityId;
  String? buildingId;
  String? floorId;
  String? unitId;
  String? slotId;
  String? locateableType;
  String? query;
  String? runningNumber;
  String? approvalNumber;
  String? agreementId;
  String? interval;
  String? locationType;
  String? workPermitExpiryIn;
  String? passportPermitExpiryIn;
  bool? hasActiveTenancy;
  bool? pendingTenancy;
  bool? hasPostEnrollment;
  bool? active;
  String? enrollmentId;
  String? issueType;
  bool? isVerified;
  bool? hasAgreement;
  bool? hasNoReplacingCallingVisa;
  bool? isReplacement;
  bool? isReplacementVisa;
  String? country;
  dynamic callingVisaId;
  List<String>? workerIds;
  String? workerId;
  bool? withSlot;
  String? postEnrollmentId;
  String? itemType;
  String? itemId;
  dynamic condition;
  bool? isStayingOutside;
  String? facilityType;
  String? workerStatus;
  bool? withActiveTenancy;
  bool? latestVersion;
  String? expiryIn;
  String? enrollmentsFrom;
  String? fromDate;
  String? toDate;
  String? assigneeId;
  String? underLocatableId;
  String? outsourceClientId;
  String? attestationId;
  String? workPermitMissionType;
  bool? isActive;
  String? locationId;
  String? notificationType;
  String? department;
  bool? hasWorkOrder;
  List<String>? exportHeaders;

  Map<String, dynamic> toJson() => {
        "page": page.toString(),
        "items": items.toString(),
        "active": active.toString(),
        "is_active": isActive.toString(),
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "status[]": status,
        "condition[]": condition,
        "client_id": clientId,
        "kdn_approval_id": approvalId,
        "facility_id": facilityId,
        "building_id": buildingId,
        "floor_id": floorId,
        "unit_id": unitId,
        "slot_id": slotId,
        "locateable_type": locateableType,
        "query": query,
        "running_number": runningNumber,
        "approval_number": approvalNumber,
        "agreement_id": agreementId,
        "interval": interval,
        "location_type": locationType,
        "work_permit_expiry_in": workPermitExpiryIn,
        "passport_expiry_in": passportPermitExpiryIn,
        "enrollment_id": enrollmentId,
        "has_active_tenancy": hasActiveTenancy.toString(),
        "pending_tenancy": pendingTenancy.toString(),
        "has_post_enrollment": hasPostEnrollment.toString(),
        "issue_type": issueType,
        "is_verified": isVerified.toString(),
        "has_agreement": hasAgreement.toString(),
        "has_no_replacing_calling_visa": hasNoReplacingCallingVisa.toString(),
        "is_replacement": isReplacement.toString(),
        "is_replacement_visa": isReplacementVisa.toString(),
        "country": country,
        "calling_visa_id[]": callingVisaId,
        "worker_ids[]": (workerIds?.isNotEmpty == true) ? workerIds : null,
        "worker_id": workerId,
        "with_slot": withSlot.toString(),
        "post_enrollment_id": postEnrollmentId,
        "item_type": itemType,
        "item_id": itemId,
        "is_staying_outside": isStayingOutside.toString(),
        "facility_type": facilityType,
        "worker_status": workerStatus,
        "with_active_tenancy": withActiveTenancy.toString(),
        "latest_version": latestVersion.toString(),
        "expiry_in": expiryIn,
        "enrolments_from": enrollmentsFrom,
        "from_date": fromDate,
        "to_date": toDate,
        "assignee_id": assigneeId,
        "under_locatable_id": underLocatableId,
        "outsource_client_id": outsourceClientId,
        "attestation_id": attestationId,
        "work_permit_mission_type": workPermitMissionType,
        "location_id": locationId,
        "notification_type": notificationType,
        "department": department,
        "has_work_order": hasWorkOrder.toString(),
        "export_headers[]": exportHeaders
      }..removeWhere((dynamic key, dynamic value) =>
          key == null || value == null || value == "null");
}
