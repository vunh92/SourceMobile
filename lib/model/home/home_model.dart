import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeModel {
  HomeModel({
    this.checkInModel,
    this.deviceModel,
    this.routeModel,
    this.salesModel,
    this.skuModel,
    this.userModel,
  });

  CheckInModel? checkInModel;
  DeviceModel? deviceModel;
  RouteModel? routeModel;
  SaleModel? salesModel;
  SkuModel? skuModel;
  UserModel? userModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
