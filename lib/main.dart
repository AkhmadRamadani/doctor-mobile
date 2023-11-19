import 'dart:async';

import 'package:doctor_mobile/core/helpers/logger_helper.dart';
import 'package:doctor_mobile/core/services/device_version_service.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/my_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await DeviceVersionService().getDeviceInfo();

      await HiveService().init();

      await initializeDateFormatting('id_ID');

      return runApp(
        const MyApp(),
      );
    },
    (error, stackTrace) {
      LoggerHelper.printMessage(
          'runZonedGuarded: Caught error in my root zone.');
      LoggerHelper.printMessage(error.toString());
      LoggerHelper.printMessage(stackTrace.toString());
    },
  );
}
