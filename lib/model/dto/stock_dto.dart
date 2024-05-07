import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'stock_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class StockResponse {
  StockResponse({
    this.id = 0,
    this.companyId = 0,
    this.coolerCheckoutId = 0,
    this.stockId = 0,
    this.stockName = '',
    this.stockCode = '',
    this.layer = 0,
    this.face = 0,
    this.total = 0,
    this.isCaching = true,
    this.title = '',
    this.description = '',
    this.status = 0,
    this.createBy = '',
    this.createbyName = '',
    this.createDate,
    this.lastUpdateBy = '',
    this.lastUpdateByName = '',
    this.lastUpdateDate,
    this.actionType = 0,
  });

  int? id;
  int? companyId;
  int? coolerCheckoutId;
  int? stockId;
  String? stockName;
  String? stockCode;
  int? layer;
  int? face;
  int? total;
  bool? isCaching;
  String? title;
  String? description;
  int? status;
  String? createBy;
  String? createbyName;
  DateTime? createDate;
  String? lastUpdateBy;
  String? lastUpdateByName;
  DateTime? lastUpdateDate;
  int? actionType;


  factory StockResponse.fromJsonApi(Map<String, dynamic> json) => StockResponse(
    id: json['ID'] as int? ?? 0,
    companyId: json['CompanyID'] as int? ?? 0,
    coolerCheckoutId: json['CoolerCheckoutID'] as int? ?? 0,
    stockId: json['StockID'] as int? ?? 0,
    stockName: json['StockName'] as String? ?? '',
    stockCode: json['StockCode'] as String? ?? '',
    layer: json['Layer'] as int? ?? 0,
    face: json['Face'] as int? ?? 0,
    total: json['Total'] as int? ?? 0,
    isCaching: json['IsCaching'] as bool? ?? true,
    title: json['Title'] as String? ?? '',
    description: json['Description'] as String? ?? '',
    status: json['Status'] as int? ?? 0,
    createBy: json['CreateBy'] as String? ?? '',
    createbyName: json['CreatebyName'] as String? ?? '',
    createDate: json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String),
    lastUpdateBy: json['LastUpdateBy'] as String? ?? '',
    lastUpdateByName: json['LastUpdateByName'] as String? ?? '',
    lastUpdateDate: json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String),
    actionType: json['ActionType'] as int? ?? 0,
  );

  factory StockResponse.fromJson(Map<String, dynamic> json) => _$StockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StockResponseToJson(this);

}