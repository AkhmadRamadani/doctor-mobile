// To parse this JSON data, do
//
//     final getMyPlacesResponse = getMyPlacesResponseFromJson(jsonString);

import 'dart:convert';

GetMyPlacesResponse getMyPlacesResponseFromJson(String str) =>
    GetMyPlacesResponse.fromJson(json.decode(str));

String getMyPlacesResponseToJson(GetMyPlacesResponse data) =>
    json.encode(data.toJson());

class GetMyPlacesResponse {
  int? statusCode;
  String? message;
  MetaMyPlaces? meta;

  GetMyPlacesResponse({
    this.statusCode,
    this.message,
    this.meta,
  });

  GetMyPlacesResponse copyWith({
    int? statusCode,
    String? message,
    MetaMyPlaces? meta,
  }) =>
      GetMyPlacesResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        meta: meta ?? this.meta,
      );

  factory GetMyPlacesResponse.fromJson(Map<String, dynamic> json) =>
      GetMyPlacesResponse(
        statusCode: json["status_code"],
        message: json["message"],
        meta: json["meta"] == null ? null : MetaMyPlaces.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "meta": meta?.toJson(),
      };
}

class MetaMyPlaces {
  int? currentPage;
  List<ItemPlace>? data;
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

  MetaMyPlaces({
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

  MetaMyPlaces copyWith({
    int? currentPage,
    List<ItemPlace>? data,
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
      MetaMyPlaces(
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

  factory MetaMyPlaces.fromJson(Map<String, dynamic> json) => MetaMyPlaces(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemPlace>.from(
                json["data"]!.map((x) => ItemPlace.fromJson(x))),
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

class ItemPlace {
  int? id;
  int? employeeId;
  String? name;
  String? address;
  int? reservationable;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  ItemPlace({
    this.id,
    this.employeeId,
    this.name,
    this.address,
    this.reservationable,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  ItemPlace copyWith({
    int? id,
    int? employeeId,
    String? name,
    String? address,
    int? reservationable,
    dynamic deletedAt,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      ItemPlace(
        id: id ?? this.id,
        employeeId: employeeId ?? this.employeeId,
        name: name ?? this.name,
        address: address ?? this.address,
        reservationable: reservationable ?? this.reservationable,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ItemPlace.fromJson(Map<String, dynamic> json) => ItemPlace(
        id: json["id"],
        employeeId: json["employee_id"],
        name: json["name"],
        address: json["address"],
        reservationable: json["reservationable"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "name": name,
        "address": address,
        "reservationable": reservationable,
        "deleted_at": deletedAt,
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
