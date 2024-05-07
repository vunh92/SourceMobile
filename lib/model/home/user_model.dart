import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.title,
    this.username,
    this.password,
    this.lastLogin,
    int? status,
    this.avatar
  });

  String? id;
  String? firstName;
  String? lastName;
  String? title;
  String? username;
  String? password;
  DateTime? lastLogin;
  int? status;
  String? avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
