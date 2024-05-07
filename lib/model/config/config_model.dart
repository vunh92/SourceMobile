import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'config_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfigModel extends ConfigEntity{
  ConfigModel({
    super.distance,
    super.hotZonePicture,
    super.outletPicture,
    super.outletHotZoneCheck,
    super.outletStockCountCheck,
    this.device,
    this.location,
  });

  DeviceModel? device;
  LocationModel? location;

  factory ConfigModel.fromJsonApi(Map<String, dynamic> json) => ConfigModel(
    distance: json['Distance'] as int? ?? 100,
    hotZonePicture: json['HotZonePicture'] as String? ?? '',
    outletPicture: json['OutletPicture'] as String? ?? '',
    outletHotZoneCheck: json['OutletHotZoneCheck'] as int? ?? 0,
    outletStockCountCheck: json['OutletStockCountCheck'] as int? ?? 0,
    device: json['Device'] == null
        ? DeviceModel()
        : DeviceModel.fromJsonApi(json['Device'] as Map<String, dynamic>),
    location: json['Location'] == null
        ? LocationModel()
        : LocationModel.fromJsonApi(
        json['Location'] as Map<String, dynamic>),
  );

  factory ConfigModel.fromJson(Map<String, dynamic> json) => _$ConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}
