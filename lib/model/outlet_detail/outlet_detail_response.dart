import 'dart:convert';

import 'package:cooler_mdlz/common/common.dart';
import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'outlet_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OutletDetailCheckIn {
  OutletDetailCheckIn({
    this.id = 0,
    this.checkInId = '',
    this.checkInDate,
    this.checkInTime = '',
    this.routeCode = '',
    this.deviceId = '',
    this.outletCode = '',
    this.coolerCode = '',
    this.currentStatus = '',
    this.checkInText = '',
  });

  int? id;
  String? checkInId;
  DateTime? checkInDate;
  String? checkInTime;
  String? routeCode;
  String? deviceId;
  String? outletCode;
  String? coolerCode;
  String? currentStatus;
  String? checkInText;

  factory OutletDetailCheckIn.fromJson(Map<String, dynamic> json) => _$OutletDetailCheckInFromJson(json);

  Map<String, dynamic> toJson() => _$OutletDetailCheckInToJson(this);

  factory OutletDetailCheckIn.mapFromJson(Map<String, dynamic> json) =>  OutletDetailCheckIn(
    id: json['ID'] as int? ?? 0,
    checkInId: json['CheckInID'] as String? ?? '',
    checkInDate: json['CheckInDate'] == null
        ? null
        : DateTime.parse(json['CheckInDate'] as String),
    checkInTime: json['CheckInTime'] as String? ?? '',
    routeCode: json['RouteCode'] as String? ?? '',
    deviceId: json['DeviceID'] as String? ?? '',
    outletCode: json['OutLetCode'] as String? ?? '',
    coolerCode: json['CoolerCode'] as String? ?? '',
    currentStatus: json['CurrentStatus'] as String? ?? '',
    checkInText: json['CheckInText'] as String? ?? '',
  );
}

@JsonSerializable(explicitToJson: true)
class OutletDetailCheckOut {
  OutletDetailCheckOut({
    this.id = 0,
    this.companyId = 0,
    this.coolerId = 0,
    this.deviceId = 0,
    this.routeId = 0,
    this.outletId = 0,
    this.scanCode = '',
    this.checkInId = '',
    this.checkOutId = '',
    this.checkInDate,
    this.checkInTime = '',
    this.checkOutDate,
    this.checkOutTime = '',
    this.scanSerialNumber = '',

    this.hotZonePicture = '',
    this.planogramPicture = '',
    this.hotZoneCompletedTime = '',
    this.stockCountCompletedTime = '',
    this.maintenancePicture1 = '',
    this.maintenancePicture2 = '',
    this.maintenancePicture3 = '',
    this.maintenanceDescription = '',
    this.currentStatus = '',
    this.status = 1,
    this.checkOutText = '',
    this.qrNote = '',
    this.questions = const [],
    this.stocks = const [],
    this.createDate,
    this.lastUpdateDate,
    this.outletHotZoneCheck = 0,
    this.outletStockCountCheck = 0,
    this.checkoutStatus = 1,
    this.coolerStatus = '',
  });

  int? id;
  int? companyId;
  int? coolerId;
  int? deviceId;
  int? routeId;
  int? outletId;
  String? scanCode;
  String? checkInId;
  String? checkOutId;
  DateTime? checkInDate;
  String? checkInTime;
  DateTime? checkOutDate;
  String? checkOutTime;
  String? scanSerialNumber;

  String? hotZonePicture;
  String? planogramPicture;
  String? hotZoneCompletedTime;
  String? stockCountCompletedTime;
  String? currentStatus;
  String? maintenancePicture1;
  String? maintenancePicture2;
  String? maintenancePicture3;
  String? maintenanceDescription;
  int? status;
  String? checkOutText;
  String? qrNote;
  List<QuestionRequest>? questions;
  List<StockRequest>? stocks;
  DateTime? createDate;
  DateTime? lastUpdateDate;
  int? outletHotZoneCheck;
  int? outletStockCountCheck;
  int? checkoutStatus;
  String? coolerStatus;

  Map<String, dynamic> toBodyCheckOut({
    required String deviceId,
    required double distance,
  }) {
    return {
      'Code': deviceId,
      'CoolerId': coolerId.toString(),
      'CoolerStatus': coolerStatus,
      'OutletId': outletId.toString(),
      'ScanCode': scanCode,
      'CheckInId': checkInId.toString(),
      'HotZonePicture': hotZonePicture,
      'PlanogramPicture': planogramPicture,
      'HotZoneCompletedTime': hotZoneCompletedTime,
      'StockCountCompletedTime': stockCountCompletedTime,
      'CurrentStatus': currentStatus,
      'CheckOutText': checkOutText,
      'ScanCodeNote': qrNote,
      "MaintenancePicture1": maintenancePicture1,
      "MaintenancePicture2": maintenancePicture2,
      "MaintenancePicture3": maintenancePicture3,
      "MaintenanceDescription": maintenanceDescription,
      'Questions': questions?.map((e) => e.toMapCheckOutBody()).toList(),
      'Stocks': stocks?.map((e) => e.toMapCheckOutBody(outletHotZoneCheck: outletHotZoneCheck ?? 0)).toList(),
      'OutletHotZoneCheck': outletHotZoneCheck,
      'OutletStockCountCheck': outletStockCountCheck,
      'CheckoutStatus': checkoutStatus,
      'CheckOutDistance': distance,
    };
  }

  factory OutletDetailCheckOut.mapFromJson(Map<String, dynamic> json)
  => OutletDetailCheckOut(
    id: json['ID'] as int? ?? 0,
    companyId: json['CompanyID'] as int? ?? 0,
    coolerId: json['CoolerID'] as int? ?? 0,
    deviceId: json['DeviceID'] as int? ?? 0,
    routeId: json['RouteID'] as int? ?? 0,
    outletId: json['OutletID'] as int? ?? 0,
    scanCode: json['ScanCode'] as String? ?? '',
    checkInId: json['CheckInID'] as String? ?? '',
    checkOutId: json['CheckOutID'] as String? ?? '',
    checkInDate: json['CheckInDate'] == null
        ? null
        : DateTime.parse(json['CheckInDate'] as String),
    checkInTime: json['CheckInTime'] as String? ?? '',
    checkOutDate: json['CheckOutDate'] == null
        ? null
        : DateTime.parse(json['CheckOutDate'] as String),
    checkOutTime: json['CheckOutTime'] as String? ?? '',
    scanSerialNumber: json['ScanSerialNumber'] as String? ?? '',
    coolerStatus: json['CoolerStatus'] as String? ?? '',
    hotZonePicture: json['HotZonePicture'] as String? ?? '',
    planogramPicture: json['PlanogramPicture'] as String? ?? '',
    hotZoneCompletedTime: json['GotZoneCompletedTime'] as String? ?? '',
    stockCountCompletedTime: json['StockCountCompletedTime'] as String? ?? '',
    maintenancePicture1: json['MaintenancePicture1'] as String? ?? '',
    maintenancePicture2: json['MaintenancePicture2'] as String? ?? '',
    maintenancePicture3: json['MaintenancePicture3'] as String? ?? '',
    maintenanceDescription: json['MaintenanceDescription'] as String? ?? '',
    currentStatus: json['CurrentStatus'] as String? ?? '',
    status: json['Status'] as int? ?? 1,
    checkOutText: json['CheckOutText'] as String? ?? '',
    qrNote: json['QRNote'] as String? ?? '',
    questions: (json['Questions'] as List<dynamic>?)
        ?.map((e) =>
        QuestionRequest.mapFromJson(e as Map<String, dynamic>))
        .toList() ??
        const [],
    stocks: (json['Stocks'] as List<dynamic>?)
        ?.map((e) => StockRequest.mapFromJson(e as Map<String, dynamic>))
        .toList() ??
        const [],
    createDate: json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String),
    lastUpdateDate: json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String),
    outletHotZoneCheck: json['OutletHotZoneCheck'] as int? ?? 0,
    outletStockCountCheck: json['OutletStockCountCheck'] as int? ?? 0,
  );

  factory OutletDetailCheckOut.fromJson(Map<String, dynamic> json) => _$OutletDetailCheckOutFromJson(json);

  Map<String, dynamic> toJson() => _$OutletDetailCheckOutToJson(this);

}
