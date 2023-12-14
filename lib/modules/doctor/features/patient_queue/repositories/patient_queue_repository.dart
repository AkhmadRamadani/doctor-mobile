import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/models/responses/approve_reject_response.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/models/responses/get_all_reservations_response.dart';

class PatientQueueRepository extends GlobalRepositoryService {
  Future<GetAllReservationsResponse> getAllReservations({
    int? page,
    int? limit,
    int? status,
    int approve = 1,
  }) async {
    try {
      var query = {
        'page': page,
        'limit': limit,
        'status': status,
        'approve': approve,
      };

      Response res = await ApiServices.call().get(
        ApiConst.reservationAll,
        queryParameters: query,
      );
      return GetAllReservationsResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetAllReservationsResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetAllReservationsResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetAllReservationsResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetAllReservationsResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<ApproveRejectResponse> approveOrRejectReservation({
    required int reservationId,
    required int status,
    String? rejectReason,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'reservation_id': reservationId,
        'status': status,
        'reason': rejectReason,
      });

      Response res = await ApiServices.call().post(
        ApiConst.reservationApprove,
        data: formData,
      );
      return ApproveRejectResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return ApproveRejectResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return ApproveRejectResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return ApproveRejectResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return ApproveRejectResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
