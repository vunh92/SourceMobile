import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'stock_response.g.dart';

@JsonSerializable(explicitToJson: true)
class StockRequest {
  StockRequest({
    this.stockId = 0,
    this.stockCode = '',
    this.stockName = '',
    this.coolerId = 0,
    this.face = 0,
    this.layer = 0,
    this.total = 0,
    this.stockPicture = '',
    this.questionId = 0,
    this.questionName = '',
    this.questionType = '',
    this.outletId = 0,
  });

  int? stockId;
  String? stockCode;
  String? stockName;
  int? coolerId;
  int? face;
  int? layer;
  int? total;
  String? stockPicture;
  int? questionId;
  String? questionName;
  String? questionType;
  int? outletId;

  factory StockRequest.mapFromJson(Map<String, dynamic> json) => StockRequest(
    questionId: json['QuestionId'] as int? ?? 0,
    questionName: json['QuestionName'] as String? ?? '',
    questionType: json['QuestionType'] as String? ?? '',
    outletId: json['OutletId'] as int? ?? 0,
    stockId: json['StockID'] as int? ?? 0,
    stockCode: json['StockCode'] as String? ?? '',
    stockName: json['StockName'] as String? ?? '',
    coolerId: json['CoolerID'] as int? ?? 0,
    face: json['Face'] as int? ?? 0,
    layer: json['Layer'] as int? ?? 0,
    total: json['Total'] as int? ?? 0,
    stockPicture: json['StockPicture'] as String? ?? '',
  );

  factory StockRequest.mapFromStock({required StockModel stock, required String questionType}) => StockRequest(
    stockId: stock.stockId,
    stockCode: stock.stockCode,
    stockName: stock.stockName,
    coolerId: stock.coolerId,
    face: stock.faceInput == -1 ? null : stock.faceInput,
    layer: stock.layer,
    total: stock.totalInput == -1 ? null : stock.totalInput,
    stockPicture: stock.stockPicture,
    questionId: stock.questionId,
    questionName: stock.questionName,
    questionType: questionType,
    outletId: stock.outletId,
  );

  Map<String, dynamic> toMapCheckOutBody({required int outletHotZoneCheck}) {
    return {
      'QuestionId': questionId,
      'QuestionName': questionName,
      'QuestionType': questionType,
      'OutletId': outletId,
      'StockId': stockId,
      'StockCode': stockCode,
      'StockName': stockName,
      'CoolerId': coolerId,
      'Face': outletHotZoneCheck == 1 ? face : face == -1 ? null : face,
      'Layer': layer,
      'Total': outletHotZoneCheck == 1 ? total : total == -1 ? null : total,
      'StockPicture': stockPicture,
    };
  }

  factory StockRequest.fromJson(Map<String, dynamic> json) =>  _$StockRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StockRequestToJson(this);

}
