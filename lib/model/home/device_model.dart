import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'device_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceModel extends DeviceEntity{
  DeviceModel({
    super.id,
    super.imei,
    super.deviceName,
    super.deviceOs,
    super.deviceType,
    super.deviceId,
    super.deviceStatus,
    super.saleId,
    super.status,
    this.uuid = '',
    this.version = '1.4.1',
    this.buildNumber = '41',
    this.sale,
  });

  String? uuid;
  String? version;
  String? buildNumber;
  SaleModel? sale;

  factory DeviceModel.fromJsonApi(Map<String, dynamic> json) => DeviceModel(
    uuid: json['uuid'] as String? ?? const Uuid().v1(),
    id: json['ID'] as int? ?? 1,
    imei: json['IMEI'] as String?,
    deviceName: json['DeviceName'] as String?,
    deviceOs: json['DeviceOS'] as String?,
    deviceType: json['DeviceType'] as String?,
    deviceId: json['DeviceID'] as String?,
    deviceStatus: json['DeviceStatus'] as int? ?? 1,
    saleId: json['SaleID'] as int? ?? 0,
    status: json['Status'] as int? ?? 1,
    // version: json['Version'] as String? ?? '1.0',
    // buildNumber: json['BuildNumber'] as String? ?? '1',
    sale: json['Sale'] == null
        ? null
        : SaleModel.fromJsonApi(json['Sale'] as Map<String, dynamic>),
  );

  factory DeviceModel.fromJson(Map<String, dynamic> json) => _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);

}
