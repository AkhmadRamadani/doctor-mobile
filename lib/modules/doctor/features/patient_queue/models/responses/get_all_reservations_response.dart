// To parse this JSON data, do
//
//     final getAllReservationsResponse = getAllReservationsResponseFromJson(jsonString);

import 'dart:convert';

GetAllReservationsResponse getAllReservationsResponseFromJson(String str) =>
    GetAllReservationsResponse.fromJson(json.decode(str));

String getAllReservationsResponseToJson(GetAllReservationsResponse data) =>
    json.encode(data.toJson());

class GetAllReservationsResponse {
  int? statusCode;
  MetaAllReservations? data;
  String? message;

  GetAllReservationsResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  GetAllReservationsResponse copyWith({
    int? statusCode,
    MetaAllReservations? data,
    String? message,
  }) =>
      GetAllReservationsResponse(
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory GetAllReservationsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllReservationsResponse(
        statusCode: json["status_code"],
        data: json["data"] == null
            ? null
            : MetaAllReservations.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
        "message": message,
      };
}

class MetaAllReservations {
  int? currentPage;
  List<ItemAllReservations>? data;
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

  MetaAllReservations({
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

  MetaAllReservations copyWith({
    int? currentPage,
    List<ItemAllReservations>? data,
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
      MetaAllReservations(
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

  factory MetaAllReservations.fromJson(Map<String, dynamic> json) =>
      MetaAllReservations(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ItemAllReservations>.from(
                json["data"]!.map((x) => ItemAllReservations.fromJson(x))),
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

class ItemAllReservations {
  int? id;
  int? patientId;
  int? scheduleId;
  String? reservationCode;
  int? bpjs;
  String? buktiPembayaran;
  String? ktp;
  String? suratRujukan;
  String? bpjsCard;
  int? nomorUrut;
  int? approve;
  int? status;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  int? placeId;
  int? employeeId;
  String? scheduleDate;
  String? scheduleTime;
  String? scheduleTimeEnd;
  int? qty;
  String? patientName;
  String? phone;
  String? placeName;
  String? paymentName;
  String? rejectReason;

  ItemAllReservations({
    this.id,
    this.patientId,
    this.scheduleId,
    this.reservationCode,
    this.bpjs,
    this.buktiPembayaran,
    this.ktp,
    this.suratRujukan,
    this.bpjsCard,
    this.nomorUrut,
    this.approve,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.placeId,
    this.employeeId,
    this.scheduleDate,
    this.scheduleTime,
    this.scheduleTimeEnd,
    this.qty,
    this.patientName,
    this.phone,
    this.placeName,
    this.paymentName,
    this.rejectReason,
  });

  ItemAllReservations copyWith({
    int? id,
    int? patientId,
    int? scheduleId,
    String? reservationCode,
    int? bpjs,
    String? buktiPembayaran,
    String? ktp,
    String? suratRujukan,
    String? bpjsCard,
    int? nomorUrut,
    int? approve,
    int? status,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
    int? placeId,
    int? employeeId,
    String? scheduleDate,
    String? scheduleTime,
    String? scheduleTimeEnd,
    int? qty,
    String? patientName,
    String? phone,
    String? placeName,
    String? paymentName,
    String? rejectReason,
  }) =>
      ItemAllReservations(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        scheduleId: scheduleId ?? this.scheduleId,
        reservationCode: reservationCode ?? this.reservationCode,
        bpjs: bpjs ?? this.bpjs,
        buktiPembayaran: buktiPembayaran ?? this.buktiPembayaran,
        ktp: ktp ?? this.ktp,
        suratRujukan: suratRujukan ?? this.suratRujukan,
        bpjsCard: bpjsCard ?? this.bpjsCard,
        nomorUrut: nomorUrut ?? this.nomorUrut,
        approve: approve ?? this.approve,
        status: status ?? this.status,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        placeId: placeId ?? this.placeId,
        employeeId: employeeId ?? this.employeeId,
        scheduleDate: scheduleDate ?? this.scheduleDate,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        scheduleTimeEnd: scheduleTimeEnd ?? this.scheduleTimeEnd,
        qty: qty ?? this.qty,
        patientName: patientName ?? this.patientName,
        phone: phone ?? this.phone,
        placeName: placeName ?? this.placeName,
        paymentName: paymentName ?? this.paymentName,
        rejectReason: rejectReason ?? this.rejectReason,
      );

  factory ItemAllReservations.fromJson(Map<String, dynamic> json) =>
      ItemAllReservations(
        id: json["id"],
        patientId: json["patient_id"],
        scheduleId: json["schedule_id"],
        reservationCode: json["reservation_code"],
        bpjs: json["bpjs"],
        buktiPembayaran: json["bukti_pembayaran"],
        ktp: json["ktp"],
        suratRujukan: json["surat_rujukan"],
        bpjsCard: json["bpjs_card"],
        nomorUrut: json["nomor_urut"],
        approve: json["approve"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        placeId: json["place_id"],
        employeeId: json["employee_id"],
        scheduleDate: json["schedule_date"],
        scheduleTime: json["schedule_time"],
        scheduleTimeEnd: json["schedule_time_end"],
        qty: json["qty"],
        patientName: json["patient_name"],
        phone: json["phone"],
        placeName: json["place_name"],
        paymentName: json["payment_name"],
        rejectReason: json["reject_reason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient_id": patientId,
        "schedule_id": scheduleId,
        "reservation_code": reservationCode,
        "bpjs": bpjs,
        "bukti_pembayaran": buktiPembayaran,
        "ktp": ktp,
        "surat_rujukan": suratRujukan,
        "bpjs_card": bpjsCard,
        "nomor_urut": nomorUrut,
        "approve": approve,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "place_id": placeId,
        "employee_id": employeeId,
        "schedule_date": scheduleDate,
        "schedule_time": scheduleTime,
        "schedule_time_end": scheduleTimeEnd,
        "qty": qty,
        "patient_name": patientName,
        "phone": phone,
        "place_name": placeName,
        "payment_name": paymentName,
        "reject_reason": rejectReason,
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
