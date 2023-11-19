import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_doctor_schedule_response.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/book_doctor_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/detail_reservation_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_all_doctor_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_doctor_places_response.dart';

class ReservationRepository extends GlobalRepositoryService {
  Future<GetAllDoctorsResponse> getAllDoctor({
    int? page,
    int? limit,
  }) async {
    try {
      var query = {
        'page': page,
        'limit': limit,
      };

      Response res = await ApiServices.call().get(
        ApiConst.doctorAll,
        queryParameters: query,
      );

      return GetAllDoctorsResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetAllDoctorsResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetAllDoctorsResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetAllDoctorsResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetAllDoctorsResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<GetDoctorPlacesResponse> getDoctorPlace({
    int? doctorId,
  }) async {
    try {
      User? user = await getCurrentUser();

      int? idDoctor = doctorId ?? user.employeeId ?? 0;
      Response res = await ApiServices.call().get(
        '${ApiConst.doctorPlaces}/$idDoctor',
      );

      return GetDoctorPlacesResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetDoctorPlacesResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetDoctorPlacesResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetDoctorPlacesResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetDoctorPlacesResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<GetDoctorScheduleResponse> getDoctorScheduleByPlace({
    required int placeId,
    required int doctorId,
  }) async {
    try {
      var query = {
        'place_id': placeId,
        'employee_id': doctorId,
      };

      Response res = await ApiServices.call().get(
        ApiConst.doctorSchedule,
        queryParameters: query,
      );

      return GetDoctorScheduleResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetDoctorScheduleResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetDoctorScheduleResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetDoctorScheduleResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetDoctorScheduleResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<BookDoctorResponse> bookDoctor({
    required int patientId,
    required int scheduleId,
    int isBpjs = 0,
    File? imagePaymentProof,
    File? imageKtp,
    File? imageReferralLetter,
    File? imageBpjsCard,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'patient_id': patientId,
        'schedule_id': scheduleId,
        'is_bpjs': isBpjs,
        'payment_proof': imagePaymentProof != null
            ? await MultipartFile.fromFile(imagePaymentProof.path)
            : null,
        'ktp_image': imageKtp != null
            ? await MultipartFile.fromFile(imageKtp.path)
            : null,
        'surat_rujukan': imageReferralLetter != null
            ? await MultipartFile.fromFile(imageReferralLetter.path)
            : null,
        'bpjs_image': imageBpjsCard != null
            ? await MultipartFile.fromFile(imageBpjsCard.path)
            : null,
      });

      Response res = await ApiServices.call().post(
        ApiConst.reservationBook,
        data: formData,
      );

      return BookDoctorResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return BookDoctorResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return BookDoctorResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return BookDoctorResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return BookDoctorResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<DetailReservationResponse> getDetailReservation({
    required int reservationId,
  }) async {
    try {
      Response res = await ApiServices.call().get(
        '${ApiConst.reservationDetail}/$reservationId',
      );
      return DetailReservationResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return DetailReservationResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return DetailReservationResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return DetailReservationResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return DetailReservationResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<int> getRemainingQuota({
    required int scheduleId,
  }) async {
    try {
      Response res = await ApiServices.call().get(
        '${ApiConst.reservationQuota}/$scheduleId',
      );
      return res.data['data'] ?? 0;
    } on DioException catch (_) {
      return 0;
    } catch (err) {
      return 0;
    }
  }
}
