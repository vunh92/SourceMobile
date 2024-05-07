import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'sale_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleModel extends SaleEntity{
  SaleModel({
    super.salesPersonCode,
    super.salesPersonName,
    super.email,
    super.phone,
    super.lineManagerID,
    super.status,
    this.id = 0,
    this.fullName = '',
    this.username = '',
  });

  int? id;
  String? fullName;
  String? username;

  factory SaleModel.fromJsonApi(Map<String, dynamic> json) => SaleModel(
    salesPersonCode: json['SalesPersonCode'] as String? ?? '',
    salesPersonName: json['SalesPersonName'] as String? ?? '',
    email: json['Email'] as String? ?? '',
    phone: json['Phone'] as String? ?? '',
    lineManagerID: json['LineManagerID'] as String? ?? '',
    status: json['Status'] as int? ?? 1,
    id: json['ID'] as int? ?? 0,
    fullName: json['FullName'] as String? ?? '',
    username: json['Username'] as String? ?? '',
  );

  factory SaleModel.fromJson(Map<String, dynamic> json) => _$SaleModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaleModelToJson(this);
}
