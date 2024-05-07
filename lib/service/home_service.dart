import 'dart:convert';

import 'package:cooler_mdlz/service/remote_service.dart';
import 'package:http/http.dart' as http;

import '../model/entities.dart';

class HomeService {
  static var client = RemoteServices.client;

  static var deviceInfoUrl = '/WidgetCooler/api/Outlet/AddDevice';
  static Future<dynamic> fetchAddDeviceInfo({required DeviceModel deviceModel}) async {
    var queryParams = '?code=${deviceModel.deviceId!}'
        '&name=${deviceModel.deviceName!}'
        '&type=${deviceModel.deviceType!}'
        '&os=${deviceModel.deviceOs!}';
    var response = await client.post(
      Uri.parse(RemoteServices.host + deviceInfoUrl + queryParams),
      headers: {
        "Accept": "application/json",
      },
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }

  static var configUrl = '/WidgetCooler/api/Outlet/Config';
  static Future<dynamic> fetchConfig(String deviceId) async {
    var response = await client.post(
      Uri.parse('${RemoteServices.host}$configUrl?code=$deviceId'),
      headers: {
        "Accept": "application/json",
      }
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }

  static var allOutletUrl = '/WidgetCooler/api/Outlet/AllOutlet';
  static Future<dynamic> fetchAllOutlet({deviceId = '', date = ''}) async {
    var queryParams = '?code=$deviceId'
        '&date=$date';
    var response = await client.post(
      Uri.parse('${RemoteServices.host}$allOutletUrl$queryParams'),
      headers: {
        "Accept": "application/json",
      }
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }

  static var allOutletVisitUrl = '/WidgetCooler/api/Outlet/AllOutletVisit';
  static Future<dynamic> fetchAllOutletVisit({deviceId = '', date = ''}) async {
    var queryParams = '?code=$deviceId'
        '&date=$date';
    var response = await client.post(
        Uri.parse('${RemoteServices.host}$allOutletVisitUrl$queryParams'),
        headers: {
          "Accept": "application/json",
        }
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }
  static var outletVisitUrl = '/WidgetCooler/api/Outlet/OutletVisit';
  static Future<dynamic> fetchOutletVisit({deviceId = '', date = ''}) async {
    var queryParams = '?code=$deviceId'
        '&date=$date';
    var response = await client.post(
      Uri.parse('${RemoteServices.host}$outletVisitUrl$queryParams'),
      headers: {
        "Accept": "application/json",
      }
    ).timeout(
      const Duration(milliseconds: RemoteServices.timeout),
      onTimeout: () => RemoteServices.responseTimeout,
    );
    return response;
  }
}
