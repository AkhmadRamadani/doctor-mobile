import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart' as getx;

class ApiServices {
  ApiServices._();

  static ApiServices? _instance;

  Dio _dioCall() {
    Dio dio = Dio();
    dio.options.baseUrl = ApiConst.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] =
        'Bearer ${HiveService().getData(HiveConst.tokenBox, HiveConst.tokenKey)}';
    dio.interceptors.add(LoggedOutInterceptor());
    return dio;
  }

  static Dio call() {
    _instance ??= ApiServices._();
    return _instance!._dioCall();
  }
}

class LoggedOutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      if ('${err.response?.data['message']}'.toLowerCase() ==
          'unauthenticated') {
        if (getx.Get.isDialogOpen ?? false) {
          return;
        }
        DialogService.showDialogProblem(
          title: 'Sesi Anda telah berakhir',
          description: 'Silakan login kembali',
          buttonOnTap: () async {
            await HiveService().clear();
            getx.Get.offAllNamed(AppRoutes.login);
          },
          barrierDismissible: false,
        );
      }
    }
    super.onError(err, handler);
  }
}
