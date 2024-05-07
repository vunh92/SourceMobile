// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$StockModelFromJson(Map<String, dynamic> json) => StockModel(
      stockId: json['stockId'] as int? ?? 0,
      stockCode: json['stockCode'] as String? ?? '',
      stockName: json['stockName'] as String? ?? '',
      coolerId: json['coolerId'] as int? ?? 0,
      face: json['face'] as int? ?? 0,
      layer: json['layer'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      stockPicture: json['stockPicture'] as String? ?? '',
      uuid: json['uuid'] as String? ?? '',
      stockCountId: json['stockCountId'] as String? ?? '',
      questionId: json['questionId'] as int? ?? 0,
      questionName: json['questionName'] as String? ?? '',
      outletId: json['outletId'] as int? ?? 0,
      faceInput: json['faceInput'] as int? ?? -1,
      totalInput: json['totalInput'] as int? ?? -1,
    );

Map<String, dynamic> _$StockModelToJson(StockModel instance) =>
    <String, dynamic>{
      'stockId': instance.stockId,
      'stockCode': instance.stockCode,
      'stockName': instance.stockName,
      'coolerId': instance.coolerId,
      'face': instance.face,
      'layer': instance.layer,
      'total': instance.total,
      'stockPicture': instance.stockPicture,
      'uuid': instance.uuid,
      'stockCountId': instance.stockCountId,
      'questionId': instance.questionId,
      'questionName': instance.questionName,
      'outletId': instance.outletId,
      'faceInput': instance.faceInput,
      'totalInput': instance.totalInput,
    };
