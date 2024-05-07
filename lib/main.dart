import 'dart:async';
import 'dart:developer' as developer;

import 'package:cooler_mdlz/app/app.dart';
import 'package:cooler_mdlz/app/utlis/shared_preferences_util.dart';
import 'package:cooler_mdlz/app/utlis/sqlite_db.dart';
import 'package:cooler_mdlz/service/connection/connection_status_singleton.dart';
import 'package:flutter/material.dart';

void main() async {
  await setupProject();
  runZonedGuarded(() {
    runApp(MobileApp());
  }, (error, stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
}

Future setupProject() async {

  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton.getInstance().initialize();
  await SqliteDb.initDatabase();
  await SharedPreferencesUtil.getInstance.initialize();
}