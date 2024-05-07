// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WelcomeModel _$WelcomeModelFromJson(Map<String, dynamic> json) => WelcomeModel(
      json['status'] as int?,
      json['message'] as String?,
      DeviceModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WelcomeModelToJson(WelcomeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.toJson(),
    };
