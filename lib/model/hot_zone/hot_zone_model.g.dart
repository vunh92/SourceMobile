// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_zone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotZoneModel _$HotZoneModelFromJson(Map<String, dynamic> json) => HotZoneModel(
      uuid: json['uuid'] as String? ?? '',
      outletId: json['outletId'] as int? ?? 0,
      hotZonePicture: json['hotZonePicture'] as String? ?? '',
      planogramPicture: json['planogramPicture'] as String? ?? '',
      hotZonePictureLocal: json['hotZonePictureLocal'] as String? ?? '',
      planogramPictureLocal: json['planogramPictureLocal'] as String? ?? '',
      surveys: (json['surveys'] as List<dynamic>?)
              ?.map((e) => SurveyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      completedTime: json['completedTime'] == null
          ? null
          : DateTime.parse(json['completedTime'] as String),
      visitDate: json['visitDate'] == null
          ? null
          : DateTime.parse(json['visitDate'] as String),
    );

Map<String, dynamic> _$HotZoneModelToJson(HotZoneModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'outletId': instance.outletId,
      'hotZonePicture': instance.hotZonePicture,
      'planogramPicture': instance.planogramPicture,
      'hotZonePictureLocal': instance.hotZonePictureLocal,
      'planogramPictureLocal': instance.planogramPictureLocal,
      'surveys': instance.surveys.map((e) => e.toJson()).toList(),
      'completedTime': instance.completedTime?.toIso8601String(),
      'visitDate': instance.visitDate?.toIso8601String(),
    };
