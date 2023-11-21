// To parse this JSON data, do
//
//     final getAllIcdsResponse = getAllIcdsResponseFromJson(jsonString);

import 'dart:convert';

GetAllIcdsResponse getAllIcdsResponseFromJson(String str) =>
    GetAllIcdsResponse.fromJson(json.decode(str));

String getAllIcdsResponseToJson(GetAllIcdsResponse data) =>
    json.encode(data.toJson());

class GetAllIcdsResponse {
  int? statusCode;
  String? message;
  MetaAllIcds? data;

  GetAllIcdsResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  GetAllIcdsResponse copyWith({
    int? statusCode,
    String? message,
    MetaAllIcds? data,
  }) =>
      GetAllIcdsResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetAllIcdsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllIcdsResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null ? null : MetaAllIcds.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class MetaAllIcds {
  int? currentPage;
  List<ItemIcds>? data;
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

  MetaAllIcds({
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

  MetaAllIcds copyWith({
    int? currentPage,
    List<ItemIcds>? data,
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
      MetaAllIcds(
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

  factory MetaAllIcds.fromJson(Map<String, dynamic> json) => MetaAllIcds(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemIcds>.from(
                json["data"]!.map((x) => ItemIcds.fromJson(x))),
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

class ItemIcds {
  String? code;
  String? nameEn;
  String? nameId;

  ItemIcds({
    this.code,
    this.nameEn,
    this.nameId,
  });

  ItemIcds copyWith({
    String? code,
    String? nameEn,
    String? nameId,
  }) =>
      ItemIcds(
        code: code ?? this.code,
        nameEn: nameEn ?? this.nameEn,
        nameId: nameId ?? this.nameId,
      );

  factory ItemIcds.fromJson(Map<String, dynamic> json) => ItemIcds(
        code: json["code"],
        nameEn: json["name_en"],
        nameId: json["name_id"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name_en": nameEn,
        "name_id": nameId,
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
