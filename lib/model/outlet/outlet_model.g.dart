// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletModel _$OutletModelFromJson(Map<String, dynamic> json) => OutletModel(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      nameNormalize: json['nameNormalize'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      long: (json['long'] as num?)?.toDouble() ?? 0.0,
      location1: json['location1'] as String? ?? '',
      location2: json['location2'] as String? ?? '',
      location3: json['location3'] as String? ?? '',
      location4: json['location4'] as String? ?? '',
      hotZonePicture: json['hotZonePicture'] as String? ?? '',
      note: json['note'] as String? ?? '',
      status: json['status'] as int? ?? 1,
      checkInDate: json['checkInDate'] == null
          ? null
          : DateTime.parse(json['checkInDate'] as String),
      checkInTime: json['checkInTime'] as String? ?? '',
      currentStatus: json['currentStatus'] as String? ?? '',
      coolerStatus: json['coolerStatus'] as String? ?? '',
      checkInId: json['checkInId'] as String? ?? '',
      checkOutDate: json['checkOutDate'] == null
          ? null
          : DateTime.parse(json['checkOutDate'] as String),
      checkOutTime: json['checkOutTime'] as String? ?? '',
      countCheckoutSuccess: json['countCheckoutSuccess'] as int? ?? 0,
      surveyId: json['surveyId'] as int? ?? 0,
      checkOutStatus: json['checkOutStatus'] as int? ?? 0,
      address: json['address'] as String? ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? 0,
      checkListData: (json['checkListData'] as List<dynamic>?)
          ?.map(
              (e) => OutletCheckOutResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutletModelToJson(OutletModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'nameNormalize': instance.nameNormalize,
      'phone': instance.phone,
      'lat': instance.lat,
      'long': instance.long,
      'location1': instance.location1,
      'location2': instance.location2,
      'location3': instance.location3,
      'location4': instance.location4,
      'hotZonePicture': instance.hotZonePicture,
      'note': instance.note,
      'status': instance.status,
      'checkInDate': instance.checkInDate?.toIso8601String(),
      'checkInTime': instance.checkInTime,
      'currentStatus': instance.currentStatus,
      'coolerStatus': instance.coolerStatus,
      'checkInId': instance.checkInId,
      'checkOutDate': instance.checkOutDate?.toIso8601String(),
      'checkOutTime': instance.checkOutTime,
      'countCheckoutSuccess': instance.countCheckoutSuccess,
      'surveyId': instance.surveyId,
      'checkOutStatus': instance.checkOutStatus,
      'address': instance.address,
      'distance': instance.distance,
      'checkListData': instance.checkListData?.map((e) => e.toJson()).toList(),
    };
