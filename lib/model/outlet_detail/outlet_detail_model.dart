import 'dart:convert';
import 'package:path/path.dart' as path;

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';
import 'package:cooler_mdlz/common/extensions/date_time_extension.dart';

part 'outlet_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OutletDetailModel extends OutletModel{
  OutletDetailModel({
    super.code,
    super.name,
    super.nameNormalize,
    super.phone,
    super.lat,
    super.long,
    super.location1,
    super.location2,
    super.location3,
    super.location4,
    super.hotZonePicture,
    super.note,
    super.status,
    super.address,
    super.distance,
    super.checkInDate,
    super.checkInTime,
    super.currentStatus,
    super.checkInId,
    super.checkOutDate,
    super.checkOutTime,
    this.uuid = '',
    this.outletId = 0,
    this.completedTime,
    this.visitDate,
  });

  String? uuid;
  int? outletId;
  DateTime? completedTime;
  DateTime? visitDate;

  factory OutletDetailModel.bindingData({required OutletModel outlet}) =>  OutletDetailModel(
    code: outlet.code,
    name: outlet.name,
    nameNormalize: outlet.nameNormalize,
    phone: outlet.phone,
    lat: outlet.lat,
    long: outlet.long,
    location1: outlet.location1,
    location2: outlet.location2,
    location3: outlet.location3,
    location4: outlet.location4,
    hotZonePicture: outlet.hotZonePicture,
    note: outlet.note,
    status: outlet.status,
    address: outlet.address,
    distance: outlet.distance,
    checkInDate: outlet.checkInDate,
    checkInTime: outlet.checkInTime,
    currentStatus: outlet.currentStatus,
    checkInId: outlet.checkInId,
    checkOutDate: outlet.checkOutDate,
    checkOutTime: outlet.checkOutTime,
    uuid: const Uuid().v1(),
    outletId: outlet.id,
    completedTime: null,
    visitDate: null,
  );

  Map<String, dynamic> toMapCheckIn({
    required OutletDetailCheckIn checkIn,
    required CoolerModel cooler,
  }) {
    return {
      'uuid': uuid,
      'code': code,
      'outletId': outletId,
      'deviceId': checkIn.deviceId,
      'routeCode': checkIn.routeCode,
      'outletCode': checkIn.outletCode,
      'coolerCode': cooler.serialNumber,
      'checkInDate': checkIn.checkInDate?.toString(),
      'checkInTime': checkIn.checkInTime,
      'checkInId': checkIn.checkInId,
      'currentStatus': checkIn.currentStatus,
      'completedTime': completedTime?.toString(),
      'visitDate': visitDate?.toString(),
    };
  }

  factory OutletDetailModel.generate(Map<String, dynamic> json, {
    required OutletModel outlet
  })
  => OutletDetailModel(
    name: outlet.name,
    nameNormalize: outlet.nameNormalize,
    phone: outlet.phone,
    lat: outlet.lat,
    long: outlet.long,
    location1: outlet.location1,
    location2: outlet.location2,
    location3: outlet.location3,
    location4: outlet.location4,
    hotZonePicture: outlet.hotZonePicture,
    note: outlet.note,
    status: outlet.status,
    address: outlet.address,
    distance: outlet.distance,
    code: json['code'] as String? ?? '',
    checkInDate: (json['checkInDate'] == null || json['checkInDate'] == 'null')
        ? null
        : DateTime.parse(json['checkInDate'] as String),
    checkInTime: json['checkInTime'] as String? ?? '',
    currentStatus: json['currentStatus'] as String? ?? '',
    checkInId: json['checkInId'] as String? ?? '',
    checkOutDate: json['checkOutDate'] == null
        ? null
        : DateTime.parse(json['checkOutDate'] as String),
    completedTime: json['completedTime'] == null
        ? null
        : DateTime.parse(json['completedTime'] as String),
    visitDate: json['visitDate'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
    checkOutTime: json['checkOutTime'] as String? ?? '',
    uuid: json['uuid'] as String? ?? '',
    outletId: json['outletId'] as int? ?? 0,
  )..id = json['id'] as int?;

  factory OutletDetailModel.fromJson(Map<String, dynamic> json) => _$OutletDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutletDetailModelToJson(this);
}
