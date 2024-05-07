import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';
import '../../common/common.dart';

part 'outlet_checkout_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class OutletCheckOutResponse {
  OutletCheckOutResponse({
    this.id = 0,
    this.companyId = 0,
    this.outletId = 0,
    this.coolerId = 0,
    this.deviceId = 0,
    this.routeId = 0,
    this.checkInId = '',
    this.checkoutId = '',
    this.checkInDate,
    this.checkInTime = '',
    this.checkOutDate,
    this.checkOutTime = '',
    this.currentStatus = '',
    this.checkOutText = '',
    this.scanSerialNumber = '',
    this.qrNote = '',
    this.coolerStatus = '',
    this.hotZonePicture = '',
    this.planogramPicture = '',
    this.hotZoneCompletedTime,
    this.stockCountCompletedTime,
    this.maintenancePicture1 = '',
    this.maintenancePicture2 = '',
    this.maintenancePicture3 = '',
    this.maintenanceDescription = '',
    this.outletHotZoneCheck = 0,
    this.outletStockCountCheck = 0,
    this.isCaching = true,
    this.surveyResult = const [],
    this.stocks = const [],
    this.title = '',
    this.description = '',
    this.status = 0,
    this.createBy  = '',
    this.createbyName = '',
    this.createDate,
    this.lastUpdateBy = '',
    this.lastUpdateByName = '',
    this.lastUpdateDate,
    this.actionType = 0,
    this.checkOutStatus = 0,
  });

  int? id;
  int? companyId;
  int? outletId;
  int? coolerId;
  int? deviceId;
  int? routeId;
  String? checkInId;
  String? checkoutId;
  DateTime? checkInDate;
  String? checkInTime;
  DateTime? checkOutDate;
  String? checkOutTime;
  String? currentStatus;
  String? checkOutText;
  String? scanSerialNumber;
  String? qrNote;
  String? coolerStatus;
  String? hotZonePicture;
  String? planogramPicture;
  DateTime? hotZoneCompletedTime;
  DateTime? stockCountCompletedTime;
  String? maintenancePicture1;
  String? maintenancePicture2;
  String? maintenancePicture3;
  String? maintenanceDescription;
  int? outletHotZoneCheck;
  int? outletStockCountCheck;
  bool? isCaching;
  List<SurveyResultResponse> surveyResult;
  List<StockResponse> stocks;
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
  int? checkOutStatus;

  factory OutletCheckOutResponse.fromJsonApi(Map<String, dynamic> json) => OutletCheckOutResponse(
    id: json['ID'] as int? ?? 0,
    companyId: json['CompanyID'] as int? ?? 0,
    outletId: json['OutletID'] as int? ?? 0,
    coolerId: json['CoolerID'] as int? ?? 0,
    deviceId: json['DeviceID'] as int? ?? 0,
    routeId: json['RouteID'] as int? ?? 0,
    checkInId: json['CheckInID'] as String? ?? '',
    checkoutId: json['CheckoutID'] as String? ?? '',
    checkInDate: json['CheckInDate'] == null
        ? null
        : DateTime.parse(json['CheckInDate'] as String),
    checkInTime: json['CheckInTime'] as String? ?? '',
    checkOutDate: json['CheckOutDate'] == null
        ? null
        : DateTime.parse(json['CheckOutDate'] as String),
    checkOutTime: json['CheckOutTime'] as String? ?? '',
    currentStatus: json['CurrentStatus'] as String? ?? '',
    checkOutText: json['CheckOutText'] as String? ?? '',
    scanSerialNumber: json['ScanSerialNumber'] as String? ?? '',
    qrNote: json['QRNote'] as String? ?? '',
    coolerStatus: json['CoolerStatus'] as String? ?? '',
    hotZonePicture: json['HotZonePicture'] as String? ?? '',
    planogramPicture: json['PlanogramPicture'] as String? ?? '',
    hotZoneCompletedTime: json['HotZoneCompletedTime'] == null
        ? null
        : DateTime.parse(json['HotZoneCompletedTime'] as String),
    stockCountCompletedTime: json['StockCountCompletedTime'] == null
        ? null
        : DateTime.parse(json['StockCountCompletedTime'] as String),
    maintenancePicture1: json['MaintenancePicture1'] as String? ?? '',
    maintenancePicture2: json['MaintenancePicture2'] as String? ?? '',
    maintenancePicture3: json['MaintenancePicture3'] as String? ?? '',
    maintenanceDescription: json['MaintenanceDescription'] as String? ?? '',
    outletHotZoneCheck: json['OutletHotZoneCheck'] as int? ?? 0,
    checkOutStatus: json['CheckOutStatus'] as int? ?? 0,
    outletStockCountCheck: json['OutletStockCountCheck'] as int? ?? 0,
    isCaching: json['IsCaching'] as bool? ?? true,
    surveyResult: (json['SurveyResult'] as List<dynamic>?)
        ?.map((e) =>
        SurveyResultResponse.fromJsonApi(e as Map<String, dynamic>))
        .toList() ??
        const [],
    stocks: (json['Stocks'] as List<dynamic>?)
        ?.map((e) => StockResponse.fromJsonApi(e as Map<String, dynamic>))
        .toList() ??
        const [],
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

  factory OutletCheckOutResponse.fromJson(Map<String, dynamic> json) => _$OutletCheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OutletCheckOutResponseToJson(this);

  ScanQrcodeModel mapScanQrcodeModel({
    required OutletDetailModel outletDetail,
    required CoolerModel cooler,
  }) => ScanQrcodeModel(
    uuid: const Uuid().v1(),
    id: coolerId,
    coolerId: coolerId,
    outletId: outletId,
    name: outletDetail.name,
    serialNumber: cooler.serialNumber,
    planogramPicture: cooler.planogramPicture,
    note: qrNote,
    status: status,
    isScan: true,
    assetStatus: scanSerialNumber == cooler.serialNumber
        ? 4 : scanSerialNumber == ScanStatusEnum.MISSING.name()
        ? 2 : scanSerialNumber == ScanStatusEnum.DAMAGE.name()
        ? 1 : 3,
    scanCode: scanSerialNumber,
    coolerModel: cooler,
    completedTime: checkOutDate,
    visitDate: checkOutDate?.typeDate(),
  );

  HotZoneModel mapHotZoneModel({
    required OutletDetailModel outletDetail,
    required SurveyModel survey,
  }) => HotZoneModel(
    uuid: const Uuid().v1(),
    outletId: outletId,
    hotZonePicture: hotZonePicture,
    planogramPicture: planogramPicture,
    surveys: [survey],
    completedTime: checkOutDate,
    visitDate: checkOutDate?.typeDate(),
  );

  StockCountModel mapStockCountModel({
    required SurveyModel survey,
    required CoolerModel cooler,
  }) => StockCountModel(
    uuid: const Uuid().v1(),
    outletId: outletId,
    questionId: survey.id,
    questionName: survey.name,
    completedTime: checkOutDate,
    stocks: cooler.stocks,
  );

  MaintenanceModel mapMaintenanceModel() => MaintenanceModel(
    uuid: const Uuid().v1(),
    maintenancePicture1: maintenancePicture1,
    maintenancePicture2: maintenancePicture2,
    maintenancePicture3: maintenancePicture3,
    description: maintenanceDescription,
  );

}