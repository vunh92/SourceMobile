import 'package:json_annotation/json_annotation.dart';

part 'route_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RouteModel {
  RouteModel({
    this.id,
    this.outletId,
    this.deviceId,
    this.status = 0,
    this.visitDate,
    this.syncTime,
  });

  int? id;
  int? outletId;
  String? deviceId;
  int? status;
  DateTime? visitDate;
  DateTime? syncTime;

  factory RouteModel.fromJson(Map<String, dynamic> json) => _$RouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteModelToJson(this);
}
