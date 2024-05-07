import 'package:json_annotation/json_annotation.dart';

part 'check_in_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckInModel {
  CheckInModel({
    this.id,
    this.routeId,
    this.checkInDate,
    this.checkInTime,
    this.checkOutTime,
    int? currentStatus = 0,
    this.checkInText,
    this.checkOutText,
    double? checkInDistance,
    this.scannedSeri,
    int? coolerStatus = 0,
    this.qrNode,
    this.hotZonePicture,
    this.planogramPicture,
    this.surveyId,
    DateTime? hotZoneCompleteTime,
    DateTime? stockCountCompleteTime,
    this.maintenancePic1,
    this.maintenancePic2,
    this.maintenancePic3,
    this.maintenanceDescription,
  });

  String? id;
  String? routeId;
  DateTime? checkInDate;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  int? currentStatus;
  String? checkInText;
  String? checkOutText;
  double? checkInDistance;
  String? scannedSeri;
  int? coolerStatus;
  String? qrNode;
  String? hotZonePicture;
  String? planogramPicture;
  String? surveyId;
  DateTime? hotZoneCompleteTime;
  DateTime? stockCountCompleteTime;
  String? maintenancePic1;
  String? maintenancePic2;
  String? maintenancePic3;
  String? maintenanceDescription;

  factory CheckInModel.fromJson(Map<String, dynamic> json) => _$CheckInModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInModelToJson(this);
}
