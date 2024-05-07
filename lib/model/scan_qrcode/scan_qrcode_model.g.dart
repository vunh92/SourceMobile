// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_qrcode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanQrcodeModel _$ScanQrcodeModelFromJson(Map<String, dynamic> json) =>
    ScanQrcodeModel(
      id: json['id'] as int? ?? 0,
      outletId: json['outletId'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      serialNumber: json['serialNumber'] as String? ?? '',
      planogramPicture: json['planogramPicture'] as String? ?? '',
      note: json['note'] as String? ?? '',
      status: json['status'] as int? ?? 1,
      uuid: json['uuid'] as String? ?? '',
      coolerId: json['coolerId'] as int? ?? 0,
      isScan: json['isScan'] as bool? ?? false,
      assetStatus: json['assetStatus'] as int? ?? -1,
      scanCode: json['scanCode'] as String? ?? '',
      coolerModel: json['coolerModel'] == null
          ? null
          : CoolerModel.fromJson(json['coolerModel'] as Map<String, dynamic>),
      completedTime: json['completedTime'] == null
          ? null
          : DateTime.parse(json['completedTime'] as String),
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
    );

Map<String, dynamic> _$ScanQrcodeModelToJson(ScanQrcodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outletId': instance.outletId,
      'name': instance.name,
      'serialNumber': instance.serialNumber,
      'planogramPicture': instance.planogramPicture,
      'note': instance.note,
      'status': instance.status,
      'uuid': instance.uuid,
      'coolerId': instance.coolerId,
      'isScan': instance.isScan,
      'assetStatus': instance.assetStatus,
      'scanCode': instance.scanCode,
      'coolerModel': instance.coolerModel?.toJson(),
      'completedTime': instance.completedTime?.toIso8601String(),
      'visitDate': instance.visitDate?.toIso8601String(),
    };
