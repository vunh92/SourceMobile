// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInModel _$CheckInModelFromJson(Map<String, dynamic> json) => CheckInModel(
      id: json['id'] as String?,
      routeId: json['routeId'] as String?,
      checkInDate: json['checkInDate'] == null
          ? null
          : DateTime.parse(json['checkInDate'] as String),
      checkInTime: json['checkInTime'] == null
          ? null
          : DateTime.parse(json['checkInTime'] as String),
      checkOutTime: json['checkOutTime'] == null
          ? null
          : DateTime.parse(json['checkOutTime'] as String),
      currentStatus: json['currentStatus'] as int? ?? 0,
      checkInText: json['checkInText'] as String?,
      checkOutText: json['checkOutText'] as String?,
      checkInDistance: (json['checkInDistance'] as num?)?.toDouble(),
      scannedSeri: json['scannedSeri'] as String?,
      coolerStatus: json['coolerStatus'] as int? ?? 0,
      qrNode: json['qrNode'] as String?,
      hotZonePicture: json['hotZonePicture'] as String?,
      planogramPicture: json['planogramPicture'] as String?,
      surveyId: json['surveyId'] as String?,
      hotZoneCompleteTime: json['hotZoneCompleteTime'] == null
          ? null
          : DateTime.parse(json['hotZoneCompleteTime'] as String),
      stockCountCompleteTime: json['stockCountCompleteTime'] == null
          ? null
          : DateTime.parse(json['stockCountCompleteTime'] as String),
      maintenancePic1: json['maintenancePic1'] as String?,
      maintenancePic2: json['maintenancePic2'] as String?,
      maintenancePic3: json['maintenancePic3'] as String?,
      maintenanceDescription: json['maintenanceDescription'] as String?,
    );

Map<String, dynamic> _$CheckInModelToJson(CheckInModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeId': instance.routeId,
      'checkInDate': instance.checkInDate?.toIso8601String(),
      'checkInTime': instance.checkInTime?.toIso8601String(),
      'checkOutTime': instance.checkOutTime?.toIso8601String(),
      'currentStatus': instance.currentStatus,
      'checkInText': instance.checkInText,
      'checkOutText': instance.checkOutText,
      'checkInDistance': instance.checkInDistance,
      'scannedSeri': instance.scannedSeri,
      'coolerStatus': instance.coolerStatus,
      'qrNode': instance.qrNode,
      'hotZonePicture': instance.hotZonePicture,
      'planogramPicture': instance.planogramPicture,
      'surveyId': instance.surveyId,
      'hotZoneCompleteTime': instance.hotZoneCompleteTime?.toIso8601String(),
      'stockCountCompleteTime':
          instance.stockCountCompleteTime?.toIso8601String(),
      'maintenancePic1': instance.maintenancePic1,
      'maintenancePic2': instance.maintenancePic2,
      'maintenancePic3': instance.maintenancePic3,
      'maintenanceDescription': instance.maintenanceDescription,
    };
