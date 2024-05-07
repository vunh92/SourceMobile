// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) => SaleModel(
      salesPersonCode: json['salesPersonCode'] as String? ?? '',
      salesPersonName: json['salesPersonName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      lineManagerID: json['lineManagerID'] as String? ?? '',
      status: json['status'] as int? ?? 1,
      id: json['id'] as int? ?? 0,
      fullName: json['fullName'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );

Map<String, dynamic> _$SaleModelToJson(SaleModel instance) => <String, dynamic>{
      'salesPersonCode': instance.salesPersonCode,
      'salesPersonName': instance.salesPersonName,
      'email': instance.email,
      'phone': instance.phone,
      'lineManagerID': instance.lineManagerID,
      'status': instance.status,
      'id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
    };
