// To parse this JSON data, do
//
//     final getMyMedicalRecordResponse = getMyMedicalRecordResponseFromJson(jsonString);

import 'dart:convert';

GetMyMedicalRecordResponse getMyMedicalRecordResponseFromJson(String str) =>
    GetMyMedicalRecordResponse.fromJson(json.decode(str));

String getMyMedicalRecordResponseToJson(GetMyMedicalRecordResponse data) =>
    json.encode(data.toJson());

class GetMyMedicalRecordResponse {
  int? statusCode;
  String? message;
  MetaMyMedicalRecord? data;

  GetMyMedicalRecordResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  GetMyMedicalRecordResponse copyWith({
    int? statusCode,
    String? message,
    MetaMyMedicalRecord? data,
  }) =>
      GetMyMedicalRecordResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetMyMedicalRecordResponse.fromJson(Map<String, dynamic> json) =>
      GetMyMedicalRecordResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : MetaMyMedicalRecord.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class MetaMyMedicalRecord {
  int? currentPage;
  List<ItemMyMedicalRecord>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  dynamic perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  MetaMyMedicalRecord({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  MetaMyMedicalRecord copyWith({
    int? currentPage,
    List<ItemMyMedicalRecord>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    String? nextPageUrl,
    String? path,
    dynamic perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      MetaMyMedicalRecord(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory MetaMyMedicalRecord.fromJson(Map<String, dynamic> json) =>
      MetaMyMedicalRecord(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemMyMedicalRecord>.from(
                json["data"]!.map((x) => ItemMyMedicalRecord.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ItemMyMedicalRecord {
  int? id;
  int? reservationId;
  String? icdCode;
  String? action;
  String? complaint;
  String? physicalExam;
  String? diagnosis;
  String? recommendation;
  String? recipe;
  String? desc;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? code;
  String? nameEn;
  String? nameId;
  String? scheduleDate;
  String? scheduleTime;
  String? scheduleTimeEnd;
  String? placeName;
  String? employeeQualification;
  String? employeeName;

  ItemMyMedicalRecord({
    this.id,
    this.reservationId,
    this.icdCode,
    this.action,
    this.complaint,
    this.physicalExam,
    this.diagnosis,
    this.recommendation,
    this.recipe,
    this.desc,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.nameEn,
    this.nameId,
    this.scheduleDate,
    this.scheduleTime,
    this.scheduleTimeEnd,
    this.placeName,
    this.employeeQualification,
    this.employeeName,
  });

  ItemMyMedicalRecord copyWith({
    int? id,
    int? reservationId,
    String? icdCode,
    String? action,
    String? complaint,
    String? physicalExam,
    String? diagnosis,
    String? recommendation,
    String? recipe,
    String? desc,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
    String? code,
    String? nameEn,
    String? nameId,
    String? scheduleDate,
    String? scheduleTime,
    String? scheduleTimeEnd,
    String? placeName,
    String? employeeQualification,
    String? employeeName,
  }) =>
      ItemMyMedicalRecord(
        id: id ?? this.id,
        reservationId: reservationId ?? this.reservationId,
        icdCode: icdCode ?? this.icdCode,
        action: action ?? this.action,
        complaint: complaint ?? this.complaint,
        physicalExam: physicalExam ?? this.physicalExam,
        diagnosis: diagnosis ?? this.diagnosis,
        recommendation: recommendation ?? this.recommendation,
        recipe: recipe ?? this.recipe,
        desc: desc ?? this.desc,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        code: code ?? this.code,
        nameEn: nameEn ?? this.nameEn,
        nameId: nameId ?? this.nameId,
        scheduleDate: scheduleDate ?? this.scheduleDate,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        scheduleTimeEnd: scheduleTimeEnd ?? this.scheduleTimeEnd,
        placeName: placeName ?? this.placeName,
        employeeQualification:
            employeeQualification ?? this.employeeQualification,
        employeeName: employeeName ?? this.employeeName,
      );

  factory ItemMyMedicalRecord.fromJson(Map<String, dynamic> json) =>
      ItemMyMedicalRecord(
        id: json["id"],
        reservationId: json["reservation_id"],
        icdCode: json["icd_code"],
        action: json["action"],
        complaint: json["complaint"],
        physicalExam: json["physical_exam"],
        diagnosis: json["diagnosis"],
        recommendation: json["recommendation"],
        recipe: json["recipe"],
        desc: json["desc"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        code: json["code"],
        nameEn: json["name_en"],
        nameId: json["name_id"],
        scheduleDate: json["schedule_date"],
        scheduleTime: json["schedule_time"],
        scheduleTimeEnd: json["schedule_time_end"],
        placeName: json["place_name"],
        employeeQualification: json["employee_qualification"],
        employeeName: json["employee_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reservation_id": reservationId,
        "icd_code": icdCode,
        "action": action,
        "complaint": complaint,
        "physical_exam": physicalExam,
        "diagnosis": diagnosis,
        "recommendation": recommendation,
        "recipe": recipe,
        "desc": desc,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "code": code,
        "name_en": nameEn,
        "name_id": nameId,
        "schedule_date": scheduleDate,
        "schedule_time": scheduleTime,
        "schedule_time_end": scheduleTimeEnd,
        "place_name": placeName,
        "employee_qualification": employeeQualification,
        "employee_name": employeeName,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
