// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockCountModel _$StockCountModelFromJson(Map<String, dynamic> json) =>
    StockCountModel(
      uuid: json['uuid'] as String? ?? '',
      outletId: json['outletId'] as int? ?? 0,
      questionId: json['questionId'] as int? ?? 0,
      questionName: json['questionName'] as String? ?? '',
      stocks: (json['stocks'] as List<dynamic>?)
              ?.map((e) => StockModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      completedTime: json['completedTime'] == null
          ? null
          : DateTime.parse(json['completedTime'] as String),
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
    );

Map<String, dynamic> _$StockCountModelToJson(StockCountModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'outletId': instance.outletId,
      'questionId': instance.questionId,
      'questionName': instance.questionName,
      'stocks': instance.stocks.map((e) => e.toJson()).toList(),
      'completedTime': instance.completedTime?.toIso8601String(),
      'visitDate': instance.visitDate?.toIso8601String(),
    };
