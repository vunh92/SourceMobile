abstract class DeviceEntity {
  DeviceEntity({
    this.id = 0,
    this.imei = '',
    this.deviceName = '',
    this.deviceOs = '',
    this.deviceType = '',
    this.deviceId = '',
    this.deviceStatus = 0,
    this.saleId = 0,
    this.status = 1,
  });

  int? id;
  String? imei;
  String? deviceName;
  String? deviceOs;
  String? deviceType;
  String? deviceId;
  int? deviceStatus;
  int? saleId;
  int? status;
}
