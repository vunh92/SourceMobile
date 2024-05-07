// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => RouteModel(
      id: json['id'] as int?,
      outletId: json['outletId'] as int?,
      deviceId: json['deviceId'] as String?,
      status: json['status'] as int? ?? 0,
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
      syncTime: json['syncTime'] == null
          ? null
          : DateTime.parse(json['syncTime'] as String),
    );

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outletId': instance.outletId,
      'deviceId': instance.deviceId,
      'status': instance.status,
      'visitDate': instance.visitDate?.toIso8601String(),
      'syncTime': instance.syncTime?.toIso8601String(),
    };
