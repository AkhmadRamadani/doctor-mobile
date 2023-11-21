// To parse this JSON data, do
//
//     final getAllDoctorsResponse = getAllDoctorsResponseFromJson(jsonString);

import 'dart:convert';

GetAllDoctorsResponse getAllDoctorsResponseFromJson(String str) =>
    GetAllDoctorsResponse.fromJson(json.decode(str));

String getAllDoctorsResponseToJson(GetAllDoctorsResponse data) =>
    json.encode(data.toJson());

class GetAllDoctorsResponse {
  int? statusCode;
  String? message;
  MetaGetAllDoctor? meta;

  GetAllDoctorsResponse({
    this.statusCode,
    this.message,
    this.meta,
  });

  GetAllDoctorsResponse copyWith({
    int? statusCode,
    String? message,
    MetaGetAllDoctor? meta,
  }) =>
      GetAllDoctorsResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        meta: meta ?? this.meta,
      );

  factory GetAllDoctorsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllDoctorsResponse(
        statusCode: json["status_code"],
        message: json["message"],
        meta: json["meta"] == null
            ? null
            : MetaGetAllDoctor.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "meta": meta?.toJson(),
      };
}

class MetaGetAllDoctor {
  int? currentPage;
  List<ItemDoctor>? data;
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

  MetaGetAllDoctor({
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

  MetaGetAllDoctor copyWith({
    int? currentPage,
    List<ItemDoctor>? data,
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
      MetaGetAllDoctor(
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

  factory MetaGetAllDoctor.fromJson(Map<String, dynamic> json) =>
      MetaGetAllDoctor(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemDoctor>.from(
                json["data"]!.map((x) => ItemDoctor.fromJson(x))),
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

class ItemDoctor {
  int? id;
  int? employeeId;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? qualification;

  ItemDoctor({
    this.id,
    this.employeeId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.qualification,
  });

  ItemDoctor copyWith({
    int? id,
    int? employeeId,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? qualification,
  }) =>
      ItemDoctor(
        id: id ?? this.id,
        employeeId: employeeId ?? this.employeeId,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        qualification: qualification ?? this.qualification,
      );

  factory ItemDoctor.fromJson(Map<String, dynamic> json) => ItemDoctor(
        id: json["id"],
        employeeId: json["employee_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        qualification: json["qualification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "qualification": qualification,
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
