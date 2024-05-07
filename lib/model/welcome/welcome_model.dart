import 'package:json_annotation/json_annotation.dart';

import '../home/device_model.dart';

part 'welcome_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WelcomeModel {
  WelcomeModel(this.status, this.message, this.data);

  int? status;
  String? message;
  DeviceModel data;

  factory WelcomeModel.fromJson(Map<String, dynamic> json) => _$WelcomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomeModelToJson(this);
}
