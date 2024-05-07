// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet_checkout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletCheckOutResponse _$OutletCheckOutResponseFromJson(
        Map<String, dynamic> json) =>
    OutletCheckOutResponse(
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      outletId: json['outletId'] as int? ?? 0,
      coolerId: json['coolerId'] as int? ?? 0,
      deviceId: json['deviceId'] as int? ?? 0,
      routeId: json['routeId'] as int? ?? 0,
      checkInId: json['checkInId'] as String? ?? '',
      checkoutId: json['checkoutId'] as String? ?? '',
      checkInDate: json['checkInDate'] == null
          ? null
          : DateTime.parse(json['checkInDate'] as String),
      checkInTime: json['checkInTime'] as String? ?? '',
      checkOutDate: json['checkOutDate'] == null
          ? null
          : DateTime.parse(json['checkOutDate'] as String),
      checkOutTime: json['checkOutTime'] as String? ?? '',
      currentStatus: json['currentStatus'] as String? ?? '',
      checkOutText: json['checkOutText'] as String? ?? '',
      scanSerialNumber: json['scanSerialNumber'] as String? ?? '',
      qrNote: json['qrNote'] as String? ?? '',
      coolerStatus: json['coolerStatus'] as String? ?? '',
      hotZonePicture: json['hotZonePicture'] as String? ?? '',
      planogramPicture: json['planogramPicture'] as String? ?? '',
      hotZoneCompletedTime: json['hotZoneCompletedTime'] == null
          ? null
          : DateTime.parse(json['hotZoneCompletedTime'] as String),
      stockCountCompletedTime: json['stockCountCompletedTime'] == null
          ? null
          : DateTime.parse(json['stockCountCompletedTime'] as String),
      maintenancePicture1: json['maintenancePicture1'] as String? ?? '',
      maintenancePicture2: json['maintenancePicture2'] as String? ?? '',
      maintenancePicture3: json['maintenancePicture3'] as String? ?? '',
      maintenanceDescription: json['maintenanceDescription'] as String? ?? '',
      outletHotZoneCheck: json['outletHotZoneCheck'] as int? ?? 0,
      outletStockCountCheck: json['outletStockCountCheck'] as int? ?? 0,
      isCaching: json['isCaching'] as bool? ?? true,
      surveyResult: (json['surveyResult'] as List<dynamic>?)
              ?.map((e) =>
                  SurveyResultResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      stocks: (json['stocks'] as List<dynamic>?)
              ?.map((e) => StockResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      createBy: json['createBy'] as String? ?? '',
      createbyName: json['createbyName'] as String? ?? '',
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      lastUpdateBy: json['lastUpdateBy'] as String? ?? '',
      lastUpdateByName: json['lastUpdateByName'] as String? ?? '',
      lastUpdateDate: json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String),
      actionType: json['actionType'] as int? ?? 0,
      checkOutStatus: json['checkOutStatus'] as int? ?? 0,
    );

Map<String, dynamic> _$OutletCheckOutResponseToJson(
        OutletCheckOutResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'outletId': instance.outletId,
      'coolerId': instance.coolerId,
      'deviceId': instance.deviceId,
      'routeId': instance.routeId,
      'checkInId': instance.checkInId,
      'checkoutId': instance.checkoutId,
      'checkInDate': instance.checkInDate?.toIso8601String(),
      'checkInTime': instance.checkInTime,
      'checkOutDate': instance.checkOutDate?.toIso8601String(),
      'checkOutTime': instance.checkOutTime,
      'currentStatus': instance.currentStatus,
      'checkOutText': instance.checkOutText,
      'scanSerialNumber': instance.scanSerialNumber,
      'qrNote': instance.qrNote,
      'coolerStatus': instance.coolerStatus,
      'hotZonePicture': instance.hotZonePicture,
      'planogramPicture': instance.planogramPicture,
      'hotZoneCompletedTime': instance.hotZoneCompletedTime?.toIso8601String(),
      'stockCountCompletedTime':
          instance.stockCountCompletedTime?.toIso8601String(),
      'maintenancePicture1': instance.maintenancePicture1,
      'maintenancePicture2': instance.maintenancePicture2,
      'maintenancePicture3': instance.maintenancePicture3,
      'maintenanceDescription': instance.maintenanceDescription,
      'outletHotZoneCheck': instance.outletHotZoneCheck,
      'outletStockCountCheck': instance.outletStockCountCheck,
      'isCaching': instance.isCaching,
      'surveyResult': instance.surveyResult.map((e) => e.toJson()).toList(),
      'stocks': instance.stocks.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'createBy': instance.createBy,
      'createbyName': instance.createbyName,
      'createDate': instance.createDate?.toIso8601String(),
      'lastUpdateBy': instance.lastUpdateBy,
      'lastUpdateByName': instance.lastUpdateByName,
      'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
      'actionType': instance.actionType,
      'checkOutStatus': instance.checkOutStatus,
    };
