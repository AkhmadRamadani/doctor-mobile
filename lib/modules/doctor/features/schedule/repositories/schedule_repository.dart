import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/models/responses/get_my_schedule_response.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';

class ScheduleRepository extends GlobalRepositoryService {
  Future<GetMyScheduleResponse> getDoctorSchedules({
    int? page,
    int? limit,
    String? fromDate,
  }) async {
    try {
      var query = {
        'page': page,
        'limit': limit,
        'from_date': fromDate,
      };

      Response res = await ApiServices.call().get(
        ApiConst.doctorMySchedule,
        queryParameters: query,
      );

      return GetMyScheduleResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetMyScheduleResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetMyScheduleResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetMyScheduleResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetMyScheduleResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<DefaultResponseHelper> createSchedule({
    required int placeId,
    required String date,
    required String startTime,
    required String endTime,
    required int qty,
  }) async {
    try {
      User? user = await getCurrentUser();

      FormData formData = FormData.fromMap({
        'employee_id': user.employeeId,
        'place_id': placeId,
        'schedule_date': date,
        'schedule_time': startTime,
        'schedule_time_end': endTime,
        'qty': qty,
      });

      Response res = await ApiServices.call().post(
        ApiConst.scheduleCreate,
        data: formData,
      );

      return DefaultResponseHelper.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return DefaultResponseHelper(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return DefaultResponseHelper.fromJson(dioError.response?.data);
        } catch (e) {
          return DefaultResponseHelper(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return DefaultResponseHelper(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<DefaultResponseHelper> updateSchedule({
    required int id,
    required int placeId,
    required String date,
    required String startTime,
    required String endTime,
    required int qty,
  }) async {
    try {
      User? user = await getCurrentUser();

      FormData formData = FormData.fromMap({
        'id': id,
        'employee_id': user.employeeId,
        'place_id': placeId,
        'schedule_date': date,
        'schedule_time': startTime,
        'schedule_time_end': endTime,
        'qty': qty,
      });

      Response res = await ApiServices.call().post(
        ApiConst.scheduleUpdate,
        data: formData,
      );

      return DefaultResponseHelper.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return DefaultResponseHelper(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return DefaultResponseHelper.fromJson(dioError.response?.data);
        } catch (e) {
          return DefaultResponseHelper(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return DefaultResponseHelper(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
