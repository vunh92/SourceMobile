// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) => ConfigModel(
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

Map<String, dynamic> _$ConfigModelToJson(ConfigModel instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'hotZonePicture': instance.hotZonePicture,
      'outletPicture': instance.outletPicture,
      'outletHotZoneCheck': instance.outletHotZoneCheck,
      'outletStockCountCheck': instance.outletStockCountCheck,
      'device': instance.device?.toJson(),
      'location': instance.location?.toJson(),
    };
