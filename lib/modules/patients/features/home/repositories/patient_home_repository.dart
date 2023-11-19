import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/features/home/models/responses/get_my_reservation_reponse.dart';

class PatientHomeRepository extends GlobalRepositoryService {
  Future<GetMyReservationsResponse> getMyReservation({
    int? patientId,
    // int status = 0,
  }) async {
    try {
      User user = await getCurrentUser();
      patientId = user.patientId;

      var query = {
        'patient_id': patientId,
        'status': "0, 1",
      };

      Response res = await ApiServices.call().get(
        ApiConst.reservationMy,
        queryParameters: query,
      );
      return GetMyReservationsResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetMyReservationsResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetMyReservationsResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetMyReservationsResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetMyReservationsResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
