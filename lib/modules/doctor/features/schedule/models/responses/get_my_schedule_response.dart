// To parse this JSON data, do
//
//     final getMyScheduleResponse = getMyScheduleResponseFromJson(jsonString);

import 'dart:convert';

GetMyScheduleResponse getMyScheduleResponseFromJson(String str) =>
    GetMyScheduleResponse.fromJson(json.decode(str));

String getMyScheduleResponseToJson(GetMyScheduleResponse data) =>
    json.encode(data.toJson());

class GetMyScheduleResponse {
  int? statusCode;
  String? message;
  MetaMySchedule? meta;
  int? employeeId;

  GetMyScheduleResponse({
    this.statusCode,
    this.message,
    this.meta,
    this.employeeId,
  });

  GetMyScheduleResponse copyWith({
    int? statusCode,
    String? message,
    MetaMySchedule? meta,
    int? employeeId,
  }) =>
      GetMyScheduleResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        meta: meta ?? this.meta,
        employeeId: employeeId ?? this.employeeId,
      );

  factory GetMyScheduleResponse.fromJson(Map<String, dynamic> json) =>
      GetMyScheduleResponse(
        statusCode: json["status_code"],
        message: json["message"],
        meta:
            json["data"] == null ? null : MetaMySchedule.fromJson(json["data"]),
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": meta?.toJson(),
        "employee_id": employeeId,
      };
}

class MetaMySchedule {
  int? currentPage;
  List<ItemMySchedule>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  dynamic perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  MetaMySchedule({
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

  MetaMySchedule copyWith({
    int? currentPage,
    List<ItemMySchedule>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    dynamic perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      MetaMySchedule(
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

  factory MetaMySchedule.fromJson(Map<String, dynamic> json) => MetaMySchedule(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemMySchedule>.from(
                json["data"]!.map((x) => ItemMySchedule.fromJson(x))),
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

class ItemMySchedule {
  int? id;
  String? scheduleDate;
  String? scheduleTime;
  String? scheduleTimeEnd;
  int? qty;
  String? placeName;
  bool? isExpired;

  ItemMySchedule({
    this.id,
    this.scheduleDate,
    this.scheduleTime,
    this.scheduleTimeEnd,
    this.qty,
    this.placeName,
    this.isExpired,
  });

  ItemMySchedule copyWith({
    int? id,
    String? scheduleDate,
    String? scheduleTime,
    String? scheduleTimeEnd,
    int? qty,
    String? placeName,
    bool? isExpired,
  }) =>
      ItemMySchedule(
        id: id ?? this.id,
        scheduleDate: scheduleDate ?? this.scheduleDate,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        scheduleTimeEnd: scheduleTimeEnd ?? this.scheduleTimeEnd,
        qty: qty ?? this.qty,
        placeName: placeName ?? this.placeName,
        isExpired: isExpired ?? this.isExpired,
      );

  factory ItemMySchedule.fromJson(Map<String, dynamic> json) => ItemMySchedule(
        id: json["id"],
        scheduleDate: json["schedule_date"],
        scheduleTime: json["schedule_time"],
        scheduleTimeEnd: json["schedule_time_end"],
        qty: json["qty"],
        placeName: json["place_name"],
        isExpired: json["is_expired"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_date": scheduleDate,
        "schedule_time": scheduleTime,
        "schedule_time_end": scheduleTimeEnd,
        "qty": qty,
        "place_name": placeName,
        "is_expired": isExpired,
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
