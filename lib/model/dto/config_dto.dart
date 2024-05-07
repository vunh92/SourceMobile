import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'config_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfigResponse {
  ConfigResponse({
    this.distance = 100,
    this.hotZonePicture = '',
    this.outletPicture = '',
    this.outletHotZoneCheck = 0,
    this.outletStockCountCheck = 0,
    this.device,
    this.location,
  });

  int? distance;
  String? hotZonePicture;
  String? outletPicture;
  int? outletHotZoneCheck;
  int? outletStockCountCheck;
  DeviceModel? device;
  LocationModel? location;

  factory ConfigResponse.fromJsonApi(Map<String, dynamic> json) => ConfigResponse(
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

  factory ConfigResponse.fromJson(Map<String, dynamic> json) => _$ConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigResponseToJson(this);

  ConfigModel mapConfigModel() => ConfigModel(
    distance: distance,
    hotZonePicture: hotZonePicture,
    outletPicture: outletPicture,
    outletHotZoneCheck: outletHotZoneCheck,
    outletStockCountCheck: outletStockCountCheck,
    device: device,
    location: location,
  );

}