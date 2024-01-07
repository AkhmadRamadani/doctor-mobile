import 'dart:async';

import 'package:doctor_mobile/core/helpers/logger_helper.dart';
import 'package:doctor_mobile/core/services/device_version_service.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/core/services/messaging_service.dart';
import 'package:doctor_mobile/firebase_options.dart';
import 'package:doctor_mobile/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // await Firebase.initializeApp(
      //   name: 'Doctor Mobile',
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      tz.initializeTimeZones();

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
