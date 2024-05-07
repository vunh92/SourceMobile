// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRequest _$StockRequestFromJson(Map<String, dynamic> json) => StockRequest(
      stockId: json['stockId'] as int? ?? 0,
      stockCode: json['stockCode'] as String? ?? '',
      stockName: json['stockName'] as String? ?? '',
      coolerId: json['coolerId'] as int? ?? 0,
      face: json['face'] as int? ?? 0,
      layer: json['layer'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      stockPicture: json['stockPicture'] as String? ?? '',
      questionId: json['questionId'] as int? ?? 0,
      questionName: json['questionName'] as String? ?? '',
      questionType: json['questionType'] as String? ?? '',
      outletId: json['outletId'] as int? ?? 0,
    );

Map<String, dynamic> _$StockRequestToJson(StockRequest instance) =>
    <String, dynamic>{
      'stockId': instance.stockId,
      'stockCode': instance.stockCode,
      'stockName': instance.stockName,
      'coolerId': instance.coolerId,
      'face': instance.face,
      'layer': instance.layer,
      'total': instance.total,
      'stockPicture': instance.stockPicture,
      'questionId': instance.questionId,
      'questionName': instance.questionName,
      'questionType': instance.questionType,
      'outletId': instance.outletId,
    };
