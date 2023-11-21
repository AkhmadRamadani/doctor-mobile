// To parse this JSON data, do
//
//     final getAllAnnouncementsResponse = getAllAnnouncementsResponseFromJson(jsonString);

import 'dart:convert';

GetAllAnnouncementsResponse getAllAnnouncementsResponseFromJson(String str) =>
    GetAllAnnouncementsResponse.fromJson(json.decode(str));

String getAllAnnouncementsResponseToJson(GetAllAnnouncementsResponse data) =>
    json.encode(data.toJson());

class GetAllAnnouncementsResponse {
  int? statusCode;
  String? message;
  MetaGetAnnouncements? meta;

  GetAllAnnouncementsResponse({
    this.statusCode,
    this.message,
    this.meta,
  });

  GetAllAnnouncementsResponse copyWith({
    int? statusCode,
    String? message,
    MetaGetAnnouncements? meta,
  }) =>
      GetAllAnnouncementsResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        meta: meta ?? this.meta,
      );

  factory GetAllAnnouncementsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllAnnouncementsResponse(
        statusCode: json["status_code"],
        message: json["message"],
        meta: json["meta"] == null
            ? null
            : MetaGetAnnouncements.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "meta": meta?.toJson(),
      };
}

class MetaGetAnnouncements {
  int? currentPage;
  List<ItemAnnouncement>? data;
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

  MetaGetAnnouncements({
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

  MetaGetAnnouncements copyWith({
    int? currentPage,
    List<ItemAnnouncement>? data,
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
      MetaGetAnnouncements(
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

  factory MetaGetAnnouncements.fromJson(Map<String, dynamic> json) =>
      MetaGetAnnouncements(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemAnnouncement>.from(
                json["data"]!.map((x) => ItemAnnouncement.fromJson(x))),
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

class ItemAnnouncement {
  int? id;
  int? employeeId;
  String? title;
  String? image;
  String? content;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? employeeName;
  String? employeeQualification;

  ItemAnnouncement({
    this.id,
    this.employeeId,
    this.title,
    this.image,
    this.content,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.employeeName,
    this.employeeQualification,
  });

  ItemAnnouncement copyWith({
    int? id,
    int? employeeId,
    String? title,
    String? image,
    String? content,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
    String? employeeName,
    String? employeeQualification,
  }) =>
      ItemAnnouncement(
        id: id ?? this.id,
        employeeId: employeeId ?? this.employeeId,
        title: title ?? this.title,
        image: image ?? this.image,
        content: content ?? this.content,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        employeeName: employeeName ?? this.employeeName,
        employeeQualification:
            employeeQualification ?? this.employeeQualification,
      );

  factory ItemAnnouncement.fromJson(Map<String, dynamic> json) =>
      ItemAnnouncement(
        id: json["id"],
        employeeId: json["employee_id"],
        title: json["title"],
        image: json["image"],
        content: json["content"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        employeeName: json["employee_name"],
        employeeQualification: json["employee_qualification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "title": title,
        "image": image,
        "content": content,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "employee_name": employeeName,
        "employee_qualification": employeeQualification,
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
