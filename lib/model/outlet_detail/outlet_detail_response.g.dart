// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletDetailCheckIn _$OutletDetailCheckInFromJson(Map<String, dynamic> json) =>
    OutletDetailCheckIn(
      id: json['id'] as int? ?? 0,
      checkInId: json['checkInId'] as String? ?? '',
      checkInDate: json['checkInDate'] == null
          ? null
          : DateTime.parse(json['checkInDate'] as String),
      checkInTime: json['checkInTime'] as String? ?? '',
      routeCode: json['routeCode'] as String? ?? '',
      deviceId: json['deviceId'] as String? ?? '',
      outletCode: json['outletCode'] as String? ?? '',
      coolerCode: json['coolerCode'] as String? ?? '',
      currentStatus: json['currentStatus'] as String? ?? '',
      checkInText: json['checkInText'] as String? ?? '',
    );

Map<String, dynamic> _$OutletDetailCheckInToJson(
        OutletDetailCheckIn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checkInId': instance.checkInId,
      'checkInDate': instance.checkInDate?.toIso8601String(),
      'checkInTime': instance.checkInTime,
      'routeCode': instance.routeCode,
      'deviceId': instance.deviceId,
      'outletCode': instance.outletCode,
      'coolerCode': instance.coolerCode,
      'currentStatus': instance.currentStatus,
      'checkInText': instance.checkInText,
    };

OutletDetailCheckOut _$OutletDetailCheckOutFromJson(
        Map<String, dynamic> json) =>
    OutletDetailCheckOut(
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      coolerId: json['coolerId'] as int? ?? 0,
      deviceId: json['deviceId'] as int? ?? 0,
      routeId: json['routeId'] as int? ?? 0,
      outletId: json['outletId'] as int? ?? 0,
      scanCode: json['scanCode'] as String? ?? '',
      checkInId: json['checkInId'] as String? ?? '',
      checkOutId: json['checkOutId'] as String? ?? '',
      checkInDate: json['checkInDate'] == null
          ? null
          : DateTime.parse(json['checkInDate'] as String),
      checkInTime: json['checkInTime'] as String? ?? '',
      checkOutDate: json['checkOutDate'] == null
          ? null
          : DateTime.parse(json['checkOutDate'] as String),
      checkOutTime: json['checkOutTime'] as String? ?? '',
      scanSerialNumber: json['scanSerialNumber'] as String? ?? '',
      hotZonePicture: json['hotZonePicture'] as String? ?? '',
      planogramPicture: json['planogramPicture'] as String? ?? '',
      hotZoneCompletedTime: json['hotZoneCompletedTime'] as String? ?? '',
      stockCountCompletedTime: json['stockCountCompletedTime'] as String? ?? '',
      maintenancePicture1: json['maintenancePicture1'] as String? ?? '',
      maintenancePicture2: json['maintenancePicture2'] as String? ?? '',
      maintenancePicture3: json['maintenancePicture3'] as String? ?? '',
      maintenanceDescription: json['maintenanceDescription'] as String? ?? '',
      currentStatus: json['currentStatus'] as String? ?? '',
      status: json['status'] as int? ?? 1,
      checkOutText: json['checkOutText'] as String? ?? '',
      qrNote: json['qrNote'] as String? ?? '',
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => QuestionRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      stocks: (json['stocks'] as List<dynamic>?)
              ?.map((e) => StockRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      lastUpdateDate: json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String),
      outletHotZoneCheck: json['outletHotZoneCheck'] as int? ?? 0,
      outletStockCountCheck: json['outletStockCountCheck'] as int? ?? 0,
      checkoutStatus: json['checkoutStatus'] as int? ?? 1,
      coolerStatus: json['coolerStatus'] as String? ?? '',
    );

Map<String, dynamic> _$OutletDetailCheckOutToJson(
        OutletDetailCheckOut instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'coolerId': instance.coolerId,
      'deviceId': instance.deviceId,
      'routeId': instance.routeId,
      'outletId': instance.outletId,
      'scanCode': instance.scanCode,
      'checkInId': instance.checkInId,
      'checkOutId': instance.checkOutId,
      'checkInDate': instance.checkInDate?.toIso8601String(),
      'checkInTime': instance.checkInTime,
      'checkOutDate': instance.checkOutDate?.toIso8601String(),
      'checkOutTime': instance.checkOutTime,
      'scanSerialNumber': instance.scanSerialNumber,
      'hotZonePicture': instance.hotZonePicture,
      'planogramPicture': instance.planogramPicture,
      'hotZoneCompletedTime': instance.hotZoneCompletedTime,
      'stockCountCompletedTime': instance.stockCountCompletedTime,
      'currentStatus': instance.currentStatus,
      'maintenancePicture1': instance.maintenancePicture1,
      'maintenancePicture2': instance.maintenancePicture2,
      'maintenancePicture3': instance.maintenancePicture3,
      'maintenanceDescription': instance.maintenanceDescription,
      'status': instance.status,
      'checkOutText': instance.checkOutText,
      'qrNote': instance.qrNote,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
      'stocks': instance.stocks?.map((e) => e.toJson()).toList(),
      'createDate': instance.createDate?.toIso8601String(),
      'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
      'outletHotZoneCheck': instance.outletHotZoneCheck,
      'outletStockCountCheck': instance.outletStockCountCheck,
      'checkoutStatus': instance.checkoutStatus,
      'coolerStatus': instance.coolerStatus,
    };
