// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepModel _$StepModelFromJson(Map<String, dynamic> json) => StepModel(
      id: json['id'] as int? ?? 0,
      outletId: json['outletId'] as int? ?? 1,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      isRequired: json['isRequired'] as int? ?? 0,
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
    );

Map<String, dynamic> _$StepModelToJson(StepModel instance) => <String, dynamic>{
      'id': instance.id,
      'outletId': instance.outletId,
      'name': instance.name,
      'icon': instance.icon,
      'status': instance.status,
      'isRequired': instance.isRequired,
      'visitDate': instance.visitDate?.toIso8601String(),
    };
