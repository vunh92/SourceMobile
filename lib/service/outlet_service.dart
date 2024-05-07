import 'dart:convert';
import 'package:dio/dio.dart' as dio;

import 'package:cooler_mdlz/service/remote_service.dart';
import 'package:path/path.dart' as path;

import '../app/utlis/utils.dart';
import '../model/entities.dart';

class OutletService {
  static var client = RemoteServices.client;

  static var checkInOutletUrl = '/WidgetCooler/api/Outlet/OutletCheckin';
  static Future<dynamic> fetchCheckInOutlet({
    required String deviceId,
    required int outletId,
    required String currentStatus,
    required String checkInText,
    required int checkoutStatus,
    required double distance,
    required String visitDate,
  }) async {
    Map<String, String> body = {
      'Code': deviceId,
      'OutletID': outletId.toString(),
      'CurrentStatus': currentStatus,
      'CheckInText': checkInText,
      'CheckoutStatus': checkoutStatus.toString(),
      'CheckInDistance': distance.toString(),
      'VisitDate': visitDate,
    };
    var response = await client.post(
      Uri.parse(RemoteServices.host + checkInOutletUrl),
      headers: {
        "Accept": "application/json",
      },
      body: body,
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }

  static var coolerUrl = '/WidgetCooler/api/Outlet/OutletCooler';
  static Future<dynamic> fetchOutletCooler({
    required String deviceId,
    required int outletId,
  }) async {
    var queryParams = '?code=$deviceId'
        '&outletID=$outletId';
    var response = await client.post(
      Uri.parse(RemoteServices.host + coolerUrl + queryParams),
      headers: {
        "Accept": "application/json",
      },
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }

  static var surveyUrl = '/WidgetCooler/api/Outlet/OutletSurvey';
  static Future<dynamic> fetchOutletSurvey({
    required String deviceId,
    required int outletId,
  }) async {
    var queryParams = '?code=$deviceId'
        '&outletID=$outletId';
    var response = await client.post(
      Uri.parse(RemoteServices.host + surveyUrl + queryParams),
      headers: {
        "Accept": "application/json",
      },
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }

  static var checkOutUrl = '/WidgetCooler/api/Outlet/OutletCheckout';
  static Future<dynamic> fetchCheckOutOutlet({
    required Map<String, dynamic> body,
  }) async {
    var response = await client.post(
      Uri.parse(RemoteServices.host + checkOutUrl),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }

  static var uploadImageUrl = '/WidgetCooler/api/Outlet/UploadFile';
  static Future<dynamic> fetchUploadFile({
    required String filePath,
  }) async {
    var formData = dio.FormData.fromMap({
      'Fileff': await dio.MultipartFile.fromFile(filePath, filename: path.basename(filePath)),
    });
    var response = await dio.Dio(dio.BaseOptions(
      connectTimeout: RemoteServices.timeout,
    )).post(
      RemoteServices.host + uploadImageUrl,
      data: formData,
    );
    return response;
  }
}
