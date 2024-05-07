// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceModel _$MaintenanceModelFromJson(Map<String, dynamic> json) =>
    MaintenanceModel(
      maintenancePicture1: json['maintenancePicture1'] as String? ?? '',
      maintenancePicture2: json['maintenancePicture2'] as String? ?? '',
      maintenancePicture3: json['maintenancePicture3'] as String? ?? '',
      description: json['description'] as String? ?? '',
      uuid: json['uuid'] as String? ?? '',
      outletId: json['outletId'] as int? ?? 0,
      maintenancePicture1Local:
          json['maintenancePicture1Local'] as String? ?? '',
      maintenancePicture2Local:
          json['maintenancePicture2Local'] as String? ?? '',
      maintenancePicture3Local:
          json['maintenancePicture3Local'] as String? ?? '',
      completedTime: json['completedTime'] == null
          ? null
          : DateTime.parse(json['completedTime'] as String),
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
    );

Map<String, dynamic> _$MaintenanceModelToJson(MaintenanceModel instance) =>
    <String, dynamic>{
      'maintenancePicture1': instance.maintenancePicture1,
      'maintenancePicture2': instance.maintenancePicture2,
      'maintenancePicture3': instance.maintenancePicture3,
      'description': instance.description,
      'uuid': instance.uuid,
      'outletId': instance.outletId,
      'maintenancePicture1Local': instance.maintenancePicture1Local,
      'maintenancePicture2Local': instance.maintenancePicture2Local,
      'maintenancePicture3Local': instance.maintenancePicture3Local,
      'completedTime': instance.completedTime?.toIso8601String(),
      'visitDate': instance.visitDate?.toIso8601String(),
    };
