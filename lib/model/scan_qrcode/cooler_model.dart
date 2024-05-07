import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'cooler_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CoolerModel extends CoolerEntity{
  CoolerModel({
    super.id,
    super.outletId,
    super.name,
    super.serialNumber,
    super.planogramPicture,
    super.note,
    super.status,
    this.stocks = const [],
  });

  List<StockModel> stocks;

  factory CoolerModel.fromJson(Map<String, dynamic> json) => _$CoolerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoolerModelToJson(this);

  factory CoolerModel.mapFromJson(Map<String, dynamic> json) => CoolerModel(
    id: json['ID'] as int? ?? 1,
    outletId: json['OutletID'] as int? ?? 1,
    name: json['Name'] as String? ?? '',
    serialNumber: json['SerialNumber'] as String? ?? '',
    planogramPicture: json['PlanogramPicture'] as String? ?? '',
    note: json['Note'] as String? ?? '',
    status: json['Status'] as int? ?? 1,
    stocks: (json['Stocks'] as List<dynamic>?)
        ?.map((e) => StockModel.fromJsonApi(e as Map<String, dynamic>))
        .toList() ??
        const [],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'outletId': outletId,
      'name': name,
      'serialNumber': serialNumber,
      'planogramPicture': planogramPicture,
      'note': note,
      'status': status,
    };
  }

  factory CoolerModel.generate(Map<String, dynamic> json) =>  _$CoolerModelFromJson(json);

}
