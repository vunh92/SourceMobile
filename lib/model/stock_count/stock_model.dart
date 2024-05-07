import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'stock_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StockModel extends StockEntity{
  StockModel({
    super.stockId,
    super.stockCode,
    super.stockName,
    super.coolerId,
    super.face,
    super.layer,
    super.total,
    super.stockPicture,
    this.uuid = '',
    this.stockCountId = '',
    this.questionId = 0,
    this.questionName = '',
    this.outletId = 0,
    this.faceInput = -1,
    this.totalInput = -1,
  });

  String? uuid;
  String? stockCountId;
  int? questionId;
  String? questionName;
  int? outletId;
  int? faceInput;
  int? totalInput;

  factory StockModel.fromJsonApi(Map<String, dynamic> json) => StockModel(
    uuid: const Uuid().v1(),
    stockCountId: json['StockCountID'] as String? ?? '',
    questionId: json['QuestionID'] as int? ?? 0,
    questionName: json['QuestionName'] as String? ?? '',
    outletId: json['OutletID'] as int? ?? 0,
    stockId: json['StockID'] as int? ?? 0,
    stockCode: json['StockCode'] as String? ?? '',
    stockName: json['StockName'] as String? ?? '',
    coolerId: json['CoolerID'] as int? ?? 0,
    face: json['Face'] as int? ?? 0,
    layer: json['Layer'] as int? ?? 0,
    total: json['Total'] as int? ?? 0,
    faceInput: json['FaceInput'] as int? ?? -1,
    totalInput: json['TotalInput'] as int? ?? -1,
    stockPicture: json['StockPicture'] as String? ?? '',
  );

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'stockCountId': stockCountId,
      'questionId': questionId,
      'questionName': questionName,
      'outletId': outletId,
      'stockId': stockId,
      'stockCode': stockCode,
      'stockName': stockName,
      'coolerId': coolerId,
      'face': face,
      'layer': layer,
      'total': total,
      'faceInput': faceInput,
      'totalInput': totalInput,
      'stockPicture': stockPicture,
    };
  }

  factory StockModel.generate(Map<String, dynamic> json) =>  _$StockModelFromJson(json);

  factory StockModel.fromJson(Map<String, dynamic> json) =>  _$StockModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockModelToJson(this);

}
