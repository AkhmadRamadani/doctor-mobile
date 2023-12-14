import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/models/responses/get_my_places_response.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';

class PlaceRepository extends GlobalRepositoryService {
  Future<GetMyPlacesResponse> getMyPlaces({
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      User user = await getCurrentUser();

      var query = {
        'page': page,
        'limit': limit,
        'search': search,
        'employee_id': user.employeeId,
      };

      Response res = await ApiServices.call().get(
        ApiConst.placesMy,
        queryParameters: query,
      );

      return GetMyPlacesResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetMyPlacesResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetMyPlacesResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetMyPlacesResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetMyPlacesResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  // create place
  // param is name and address
  Future<DefaultResponseHelper> createPlace({
    required String name,
    required String address,
  }) async {
    try {
      User user = await getCurrentUser();

      var body = {
        'name': name,
        'address': address,
        'employee_id': user.employeeId,
        'reservationable': 1,
      };

      Response res = await ApiServices.call().post(
        ApiConst.placesCreate,
        data: body,
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

  Future<DefaultResponseHelper> updatePlace({
    required int id,
    required String name,
    required String address,
  }) async {
    try {
      User user = await getCurrentUser();

      var body = {
        'id': id,
        'name': name,
        'address': address,
        'employee_id': user.employeeId,
        'reservationable': 1,
      };

      Response res = await ApiServices.call().post(
        ApiConst.placesUpdate,
        data: body,
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

  Future<DefaultResponseHelper> deletePlace({
    required int id,
  }) async {
    try {
      var query = {
        'id': id,
      };

      Response res = await ApiServices.call().post(
        ApiConst.placesDelete,
        queryParameters: query,
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
