// To parse this JSON data, do
//
//     final getAllNotificationsResponse = getAllNotificationsResponseFromJson(jsonString);

import 'dart:convert';

GetAllNotificationsResponse getAllNotificationsResponseFromJson(String str) =>
    GetAllNotificationsResponse.fromJson(json.decode(str));

String getAllNotificationsResponseToJson(GetAllNotificationsResponse data) =>
    json.encode(data.toJson());

class GetAllNotificationsResponse {
  int? statusCode;
  String? message;
  MetaAllNotifications? data;

  GetAllNotificationsResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  GetAllNotificationsResponse copyWith({
    int? statusCode,
    String? message,
    MetaAllNotifications? data,
  }) =>
      GetAllNotificationsResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetAllNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllNotificationsResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : MetaAllNotifications.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class MetaAllNotifications {
  int? currentPage;
  List<ItemAllNotifications>? data;
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

  MetaAllNotifications({
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

  MetaAllNotifications copyWith({
    int? currentPage,
    List<ItemAllNotifications>? data,
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
      MetaAllNotifications(
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

  factory MetaAllNotifications.fromJson(Map<String, dynamic> json) =>
      MetaAllNotifications(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemAllNotifications>.from(
                json["data"]!.map((x) => ItemAllNotifications.fromJson(x))),
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

class ItemAllNotifications {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  String? data;
  dynamic readAt;
  String? createdAt;
  String? updatedAt;

  ItemAllNotifications({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  ItemAllNotifications copyWith({
    String? id,
    String? type,
    String? notifiableType,
    int? notifiableId,
    String? data,
    dynamic readAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      ItemAllNotifications(
        id: id ?? this.id,
        type: type ?? this.type,
        notifiableType: notifiableType ?? this.notifiableType,
        notifiableId: notifiableId ?? this.notifiableId,
        data: data ?? this.data,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ItemAllNotifications.fromJson(Map<String, dynamic> json) =>
      ItemAllNotifications(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: json["data"],
        readAt: json["read_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data,
        "read_at": readAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
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
