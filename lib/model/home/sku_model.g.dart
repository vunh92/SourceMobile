// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sku_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkuModel _$SkuModelFromJson(Map<String, dynamic> json) => SkuModel(
      id: json['id'] as String?,
      outletId: json['outletId'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      face: json['face'] as int? ?? 0,
      layer: json['layer'] as int? ?? 1,
      total: (json['total'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$SkuModelToJson(SkuModel instance) => <String, dynamic>{
      'id': instance.id,
      'outletId': instance.outletId,
      'name': instance.name,
      'image': instance.image,
      'face': instance.face,
      'layer': instance.layer,
      'total': instance.total,
    };
