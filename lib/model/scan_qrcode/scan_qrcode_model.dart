import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';
import '../../common/common.dart';

part 'scan_qrcode_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ScanQrcodeModel extends CoolerEntity{
  ScanQrcodeModel({
    super.id,
    super.outletId,
    super.name,
    super.serialNumber,
    super.planogramPicture,
    super.note,
    super.status,
    this.uuid = '',
    this.coolerId = 0,
    this.isScan = false,
    this.assetStatus = -1,
    this.scanCode = '',
    this.coolerModel,
    this.completedTime,
    this.visitDate,
  });

  String? uuid;
  int? coolerId;
  bool? isScan;
  int? assetStatus;
  String? scanCode;
  CoolerModel? coolerModel;
  DateTime? completedTime;
  DateTime? visitDate;

  factory ScanQrcodeModel.fromJson(Map<String, dynamic> json) => _$ScanQrcodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrcodeModelToJson(this);

  factory ScanQrcodeModel.bindingData({
    required CoolerModel coolerModel,
    required int outletId,
  }) => ScanQrcodeModel(
    uuid: const Uuid().v1(),
    id: coolerModel.id,
    coolerId: coolerModel.id,
    outletId: outletId,
    name: coolerModel.name,
    serialNumber: coolerModel.serialNumber,
    planogramPicture: coolerModel.planogramPicture,
    note: coolerModel.note,
    status: coolerModel.status,
    isScan: false,
    assetStatus: -1,
    scanCode: '',
    coolerModel: coolerModel,
    completedTime: null,
    visitDate: null,
  );

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'coolerId': coolerId,
      'outletId': outletId,
      'name': name,
      'serialNumber': serialNumber,
      'planogramPicture': planogramPicture,
      'note': note,
      'status': status,
      'isScan': isScan,
      'assetStatus': assetStatus,
      'scanCode': scanCode,
      'completedTime': completedTime?.toString(),
      'visitDate': visitDate?.typeDate().toString(),
    };
  }

  factory ScanQrcodeModel.generate(Map<String, dynamic> json, {required CoolerModel coolerModel}) => ScanQrcodeModel(
    uuid: json['uuid'] as String? ?? '',
    id: json['id'] as int? ?? 0,
    coolerId: json['coolerId'] as int? ?? 0,
    outletId: json['outletId'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    serialNumber: json['serialNumber'] as String? ?? '',
    planogramPicture: json['planogramPicture'] as String? ?? '',
    status: json['status'] as int? ?? 0,
    note: json['note'] as String? ?? '',
    isScan: (json['isScan'] as num?) == 1,
    assetStatus: json['assetStatus'] as int? ?? -1,
    scanCode: json['scanCode'] as String? ?? '',
    coolerModel: coolerModel,
    completedTime: json['completedTime'] == null
        ? null
        : DateTime.parse(json['completedTime'] as String),
    visitDate: json['visitDate'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
  );
  factory ScanQrcodeModel.generateNoColler(Map<String, dynamic> json) => ScanQrcodeModel(
    uuid: json['uuid'] as String? ?? '',
    id: json['id'] as int? ?? 0,
    coolerId: json['coolerId'] as int? ?? 0,
    outletId: json['outletId'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    serialNumber: json['serialNumber'] as String? ?? '',
    planogramPicture: json['planogramPicture'] as String? ?? '',
    status: json['status'] as int? ?? 0,
    note: json['note'] as String? ?? '',
    isScan: (json['isScan'] as num?) == 1,
    assetStatus: json['assetStatus'] as int? ?? -1,
    scanCode: json['scanCode'] as String? ?? '',
    completedTime: json['completedTime'] == null
        ? null
        : DateTime.parse(json['completedTime'] as String),
    visitDate: json['visitDate'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
  );
}
