// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cooler_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoolerResponse _$CoolerResponseFromJson(Map<String, dynamic> json) =>
    CoolerResponse(
      coolers: (json['coolers'] as List<dynamic>?)
              ?.map((e) => CoolerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CoolerResponseToJson(CoolerResponse instance) =>
    <String, dynamic>{
      'coolers': instance.coolers.map((e) => e.toJson()).toList(),
    };
