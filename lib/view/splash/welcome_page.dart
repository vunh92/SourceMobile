import 'dart:io';

import 'package:cooler_mdlz/controller/home_controller.dart';
import 'package:cooler_mdlz/view/home/home_page.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../../app/utlis/utils.dart';
import '../../common/common.dart';
import '../../model/home/device_model.dart';

class _Constant {
  static const loading = 'Đang tải...';
}

class WelcomeScreen extends StatefulWidget {
  static const route = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late OwnThemeFields themeOwn;
  HomeController homeController = Get.find<HomeController>();

  Future<bool> _checkPhonePermission() async {
    return await Permission.phone.request().isGranted;
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    final phoneStatus = _checkPhonePermission();
    phoneStatus.then((status) {
      if(!status) SystemNavigator.pop();
      final location = _determinePosition();
      location.then((location) {
        homeController.setLocation = location;
        _initPlatformDevice();
      }).onError((error, stackTrace) {
        SystemNavigator.pop();
      });
    }).onError((error, stackTrace) {
      SystemNavigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    themeOwn = Theme.of(context).own();
    return Scaffold(
      body: Container(
        color: themeOwn.mainColor,
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: NumberConstant.heightDevice(context) / 4,
                    ),
                    child: Image.asset(
                      assetImagePath + logoApp,
                      height: NumberConstant.heightDevice(context) / 8,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Image.asset(
                        assetImagePath + logoBottomApp,
                        fit: BoxFit.fitHeight,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: NumberConstant.heightDevice(context) / 10,
                        ),
                        child: Text(_Constant.loading,
                          style: AppTextStyle.textStyleLoading,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Future<void> _initPlatformDevice() async {
    late String platformVersion, imei = '', deviceName = '', deviceType = '';
    try {
      platformVersion = await DeviceInformation.platformVersion;
      imei = await DeviceInformation.deviceIMEINumber;
      deviceName = await DeviceInformation.deviceModel;
      deviceType = await DeviceInformation.deviceManufacturer;
    } on PlatformException catch (e) {
      platformVersion = '${e.message}';
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    final deviceInfoPlugin = DeviceInfoPlugin();
    final result = await deviceInfoPlugin.deviceInfo;
    Map info = result.toMap();
    DeviceModel deviceModel = DeviceModel(
      version: version,
      buildNumber: buildNumber,
      imei: imei,
      deviceId: info['id'],
      deviceName: deviceName,
      deviceOs: platformVersion,
      deviceType: deviceType,
    );

    await homeController.setInfoDevice(deviceModel: deviceModel);
    await homeController.checkDeviceFromApi(
      deviceId: deviceModel.deviceId,
      // deviceId: 'SP1A.210812.016',
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
