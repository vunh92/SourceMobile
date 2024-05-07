// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigResponse _$ConfigResponseFromJson(Map<String, dynamic> json) =>
    ConfigResponse(
      distance: json['distance'] as int? ?? 100,
      hotZonePicture: json['hotZonePicture'] as String? ?? '',
      outletPicture: json['outletPicture'] as String? ?? '',
      outletHotZoneCheck: json['outletHotZoneCheck'] as int? ?? 0,
      outletStockCountCheck: json['outletStockCountCheck'] as int? ?? 0,
      device: json['device'] == null
          ? null
          : DeviceModel.fromJson(json['device'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfigResponseToJson(ConfigResponse instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'hotZonePicture': instance.hotZonePicture,
      'outletPicture': instance.outletPicture,
      'outletHotZoneCheck': instance.outletHotZoneCheck,
      'outletStockCountCheck': instance.outletStockCountCheck,
      'device': instance.device?.toJson(),
      'location': instance.location?.toJson(),
    };
