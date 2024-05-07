// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      checkInModel: json['checkInModel'] == null
          ? null
          : CheckInModel.fromJson(json['checkInModel'] as Map<String, dynamic>),
      deviceModel: json['deviceModel'] == null
          ? null
          : DeviceModel.fromJson(json['deviceModel'] as Map<String, dynamic>),
      routeModel: json['routeModel'] == null
          ? null
          : RouteModel.fromJson(json['routeModel'] as Map<String, dynamic>),
      salesModel: json['salesModel'] == null
          ? null
          : SaleModel.fromJson(json['salesModel'] as Map<String, dynamic>),
      skuModel: json['skuModel'] == null
          ? null
          : SkuModel.fromJson(json['skuModel'] as Map<String, dynamic>),
      userModel: json['userModel'] == null
          ? null
          : UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'checkInModel': instance.checkInModel?.toJson(),
      'deviceModel': instance.deviceModel?.toJson(),
      'routeModel': instance.routeModel?.toJson(),
      'salesModel': instance.salesModel?.toJson(),
      'skuModel': instance.skuModel?.toJson(),
      'userModel': instance.userModel?.toJson(),
    };
