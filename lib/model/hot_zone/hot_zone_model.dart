import 'package:cooler_mdlz/common/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'hot_zone_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HotZoneModel {
  HotZoneModel({
    this.uuid = '',
    this.outletId = 0,
    this.hotZonePicture = '',
    this.planogramPicture = '',
    this.hotZonePictureLocal = '',
    this.planogramPictureLocal = '',
    this.surveys = const [],
    this.completedTime,
    this.visitDate,
  });

  String? uuid;
  int? outletId;
  String? hotZonePicture;
  String? planogramPicture;
  String? hotZonePictureLocal;
  String? planogramPictureLocal;
  List<SurveyModel> surveys;
  DateTime? completedTime;
  DateTime? visitDate;

  factory HotZoneModel.bindingData({
    required int outletId,
  }) => HotZoneModel(
    uuid: const Uuid().v1(),
    outletId: outletId,
    hotZonePicture: '',
    planogramPicture: '',
    hotZonePictureLocal: '',
    planogramPictureLocal: '',
    surveys: [],
    completedTime: null,
    visitDate: null,
  );

  factory HotZoneModel.fromJson(Map<String, dynamic> json) => _$HotZoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotZoneModelToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'outletId': outletId,
      'hotZonePicture': hotZonePicture,
      'planogramPicture': planogramPicture,
      'hotZonePictureLocal': hotZonePictureLocal,
      'planogramPictureLocal': planogramPictureLocal,
      'completedTime': completedTime?.toString(),
      'visitDate': visitDate?.typeDate().toString(),
    };
  }

  factory HotZoneModel.generate(Map<String, dynamic> json) => HotZoneModel(
    uuid: json['uuid'] as String? ?? const Uuid().v1(),
    outletId: json['outletId'] as int? ?? 0,
    hotZonePicture: json['hotZonePicture'] as String? ?? '',
    planogramPicture: json['planogramPicture'] as String? ?? '',
    hotZonePictureLocal: json['hotZonePictureLocal'] as String? ?? '',
    planogramPictureLocal: json['planogramPictureLocal'] as String? ?? '',
    surveys: (json['surveys'] as List<dynamic>?)
        ?.map((e) => SurveyModel.generate(e as Map<String, dynamic>))
        .toList() ??
        const [],
    completedTime: json['completedTime'] == null
        ? null
        : DateTime.parse(json['completedTime'] as String),
    visitDate: json['visitDate'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
  );

}
