import 'package:json_annotation/json_annotation.dart';

part 'sku_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SkuModel {
  SkuModel({
    this.id,
    this.outletId,
    this.name,
    this.image,
    this.face = 0,
    this.layer = 1,
    this.total = 0,
  });

  String? id;
  int? outletId;
  String? name;
  String? image;
  int? face;
  int? layer;
  double? total;

  factory SkuModel.fromJson(Map<String, dynamic> json) => _$SkuModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkuModelToJson(this);
}
