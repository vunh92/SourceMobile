// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      id: json['id'] as int? ?? 0,
      imei: json['imei'] as String? ?? '',
      deviceName: json['deviceName'] as String? ?? '',
      deviceOs: json['deviceOs'] as String? ?? '',
      deviceType: json['deviceType'] as String? ?? '',
      deviceId: json['deviceId'] as String? ?? '',
      deviceStatus: json['deviceStatus'] as int? ?? 0,
      saleId: json['saleId'] as int? ?? 0,
      status: json['status'] as int? ?? 1,
      uuid: json['uuid'] as String? ?? '',
      version: json['version'] as String? ?? '1.2.8',
      buildNumber: json['buildNumber'] as String? ?? '28',
      sale: json['sale'] == null
          ? null
          : SaleModel.fromJson(json['sale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imei': instance.imei,
      'deviceName': instance.deviceName,
      'deviceOs': instance.deviceOs,
      'deviceType': instance.deviceType,
      'deviceId': instance.deviceId,
      'deviceStatus': instance.deviceStatus,
      'saleId': instance.saleId,
      'status': instance.status,
      'uuid': instance.uuid,
      'version': instance.version,
      'buildNumber': instance.buildNumber,
      'sale': instance.sale?.toJson(),
    };
