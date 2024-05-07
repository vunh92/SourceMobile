// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cooler_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoolerModel _$CoolerModelFromJson(Map<String, dynamic> json) => CoolerModel(
      id: json['id'] as int? ?? 0,
      outletId: json['outletId'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      serialNumber: json['serialNumber'] as String? ?? '',
      planogramPicture: json['planogramPicture'] as String? ?? '',
      note: json['note'] as String? ?? '',
      status: json['status'] as int? ?? 1,
      stocks: (json['stocks'] as List<dynamic>?)
              ?.map((e) => StockModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CoolerModelToJson(CoolerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outletId': instance.outletId,
      'name': instance.name,
      'serialNumber': instance.serialNumber,
      'planogramPicture': instance.planogramPicture,
      'note': instance.note,
      'status': instance.status,
      'stocks': instance.stocks.map((e) => e.toJson()).toList(),
    };
