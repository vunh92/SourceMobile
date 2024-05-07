import 'dart:convert';
import 'package:get/get.dart';

import '../model/home/device_model.dart';
import '../model/welcome/welcome_model.dart';
import '../service/remote_service.dart';

class WelcomeController extends GetxController {
  var devices = <DeviceModel>[].obs;
  RxString deviceId = ''.obs;
  RxBool isPageLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

}
