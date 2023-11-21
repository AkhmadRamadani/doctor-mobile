import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  RxBool isDoctor = false.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isDoctor =
        (HiveService().getData(HiveConst.accessBox, HiveConst.accessKey) == 2 ||
                HiveService()
                        .getData(HiveConst.accessBox, HiveConst.accessKey) ==
                    1)
            ? true.obs
            : false.obs;
  }
}
