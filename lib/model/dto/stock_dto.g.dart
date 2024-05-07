// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockResponse _$StockResponseFromJson(Map<String, dynamic> json) =>
    StockResponse(
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      coolerCheckoutId: json['coolerCheckoutId'] as int? ?? 0,
      stockId: json['stockId'] as int? ?? 0,
      stockName: json['stockName'] as String? ?? '',
      stockCode: json['stockCode'] as String? ?? '',
      layer: json['layer'] as int? ?? 0,
      face: json['face'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      isCaching: json['isCaching'] as bool? ?? true,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      createBy: json['createBy'] as String? ?? '',
      createbyName: json['createbyName'] as String? ?? '',
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      lastUpdateBy: json['lastUpdateBy'] as String? ?? '',
      lastUpdateByName: json['lastUpdateByName'] as String? ?? '',
      lastUpdateDate: json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String),
      actionType: json['actionType'] as int? ?? 0,
    );

Map<String, dynamic> _$StockResponseToJson(StockResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'coolerCheckoutId': instance.coolerCheckoutId,
      'stockId': instance.stockId,
      'stockName': instance.stockName,
      'stockCode': instance.stockCode,
      'layer': instance.layer,
      'face': instance.face,
      'total': instance.total,
      'isCaching': instance.isCaching,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'createBy': instance.createBy,
      'createbyName': instance.createbyName,
      'createDate': instance.createDate?.toIso8601String(),
      'lastUpdateBy': instance.lastUpdateBy,
      'lastUpdateByName': instance.lastUpdateByName,
      'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
      'actionType': instance.actionType,
    };
