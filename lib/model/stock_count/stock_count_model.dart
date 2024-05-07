import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'stock_count_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StockCountModel {
  StockCountModel({
    this.uuid = '',
    this.outletId = 0,
    this.questionId = 0,
    this.questionName = '',
    this.stocks = const [],
    this.completedTime,
    this.visitDate,
  });

  String? uuid;
  int? outletId;
  int? questionId;
  String? questionName;
  List<StockModel> stocks;
  DateTime? completedTime;
  DateTime? visitDate;

  factory StockCountModel.bindingData({
    required int outletId,
    required SurveyModel survey,
    required List<StockModel> stocks,
  }) => StockCountModel(
    uuid: const Uuid().v1(),
    outletId: outletId,
    questionId: survey.id,
    questionName: survey.name,
    stocks: stocks,
    completedTime: null,
    visitDate: null,
  );

  factory StockCountModel.fromJsonApi(Map<String, dynamic> json) => StockCountModel(
    uuid: json['uuid'] as String? ?? const Uuid().v1(),
    questionId: json['QuestionID'] as int? ?? 0,
    questionName: json['QuestionName'] as String? ?? '',
    outletId: json['OutletID'] as int? ?? 0,
    stocks: (json['Stocks'] as List<dynamic>?)
        ?.map((e) => StockModel.fromJsonApi(e as Map<String, dynamic>))
        .toList() ??
        const [],
    completedTime: json['CompletedTime'] == null
        ? null
        : DateTime.parse(json['CompletedTime'] as String),
    visitDate: json['VisitDate'] == null
        ? null
        : DateTime.parse(json['VisitDate'] as String),
  );

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'questionId': questionId,
      'questionName': questionName,
      'outletId': outletId,
      'completedTime': completedTime?.toString(),
      'visitDate': visitDate?.toString(),
    };
  }

  factory StockCountModel.generate(Map<String, dynamic> json) =>  StockCountModel(
    uuid: json['uuid'] as String? ?? '',
    outletId: json['outletId'] as int? ?? 0,
    questionId: json['questionId'] as int? ?? 0,
    questionName: json['questionName'] as String? ?? '',
    stocks: [],
    completedTime: json['completedTime'] == null
        ? null
        : DateTime.parse(json['completedTime'] as String),
    visitDate: json['visitDate'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
  );

  factory StockCountModel.fromJson(Map<String, dynamic> json) => _$StockCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockCountModelToJson(this);

}
