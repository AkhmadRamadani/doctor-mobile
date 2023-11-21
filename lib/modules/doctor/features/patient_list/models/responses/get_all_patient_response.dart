// To parse this JSON data, do
//
//     final getAllPatientsResponse = getAllPatientsResponseFromJson(jsonString);

import 'dart:convert';

GetAllPatientsResponse getAllPatientsResponseFromJson(String str) =>
    GetAllPatientsResponse.fromJson(json.decode(str));

String getAllPatientsResponseToJson(GetAllPatientsResponse data) =>
    json.encode(data.toJson());

class GetAllPatientsResponse {
  int? statusCode;
  String? message;
  MetaAllPatient? data;

  GetAllPatientsResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  GetAllPatientsResponse copyWith({
    int? statusCode,
    String? message,
    MetaAllPatient? data,
  }) =>
      GetAllPatientsResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetAllPatientsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllPatientsResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data:
            json["data"] == null ? null : MetaAllPatient.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class MetaAllPatient {
  int? currentPage;
  List<ItemAllPatient>? data;
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

  MetaAllPatient({
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

  MetaAllPatient copyWith({
    int? currentPage,
    List<ItemAllPatient>? data,
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
      MetaAllPatient(
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

  factory MetaAllPatient.fromJson(Map<String, dynamic> json) => MetaAllPatient(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemAllPatient>.from(
                json["data"]!.map((x) => ItemAllPatient.fromJson(x))),
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

class ItemAllPatient {
  int? id;
  int? userId;
  int? height;
  int? weight;
  dynamic accessCode;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  String? userName;
  String? birthDate;
  String? gender;
  String? phone;
  String? address;
  String? email;

  ItemAllPatient({
    this.id,
    this.userId,
    this.height,
    this.weight,
    this.accessCode,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.birthDate,
    this.gender,
    this.phone,
    this.address,
    this.email,
  });

  ItemAllPatient copyWith({
    int? id,
    int? userId,
    int? height,
    int? weight,
    dynamic accessCode,
    dynamic deletedAt,
    dynamic createdAt,
    dynamic updatedAt,
    String? userName,
    String? birthDate,
    String? gender,
    String? phone,
    String? address,
    String? email,
  }) =>
      ItemAllPatient(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        accessCode: accessCode ?? this.accessCode,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userName: userName ?? this.userName,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        email: email ?? this.email,
      );

  factory ItemAllPatient.fromJson(Map<String, dynamic> json) => ItemAllPatient(
        id: json["id"],
        userId: json["user_id"],
        height: json["height"],
        weight: json["weight"],
        accessCode: json["access_code"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userName: json["user_name"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        phone: json["phone"],
        address: json["address"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "height": height,
        "weight": weight,
        "access_code": accessCode,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_name": userName,
        "birth_date": birthDate,
        "gender": gender,
        "phone": phone,
        "address": address,
        "email": email,
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
