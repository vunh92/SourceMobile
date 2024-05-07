import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../common/common.dart';

part 'step_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StepModel {
  StepModel({
    this.id = 0,
    this.outletId = 1,
    this.name = '',
    this.icon = '',
    this.status = 0,
    this.isRequired = 0,
    this.visitDate,
  });

  int? id;
  int? outletId;
  String? name;
  String? icon;
  int? status;
  int? isRequired;
  DateTime? visitDate;

  factory StepModel.fromJson(Map<String, dynamic> json) => _$StepModelFromJson(json);

  Map<String, dynamic> toJson() => _$StepModelToJson(this);

  static List<StepModel> newSteps({
    required int outletId,
    required DateTime? visitDate,
    required int outletHotZoneCheck,
    required int outletStockCountCheck,
  }) => <StepModel>[
    StepModel(
      id: 1,
      outletId: outletId,
      name: AppString.scanQrcode,
      icon: assetIconsPath + iconQrcodeSvg,
      isRequired: 1,
      visitDate: visitDate,
    ),
    StepModel(
      id: 2,
      outletId: outletId,
      name: AppString.hotZone,
      icon: assetIconsPath + iconImageSvg,
      isRequired: outletHotZoneCheck,
      visitDate: visitDate,
    ),
    // StepModel(
    //   id: 3,
    //   outletId: outletId,
    //   name: AppString.stockCount,
    //   icon: assetIconsPath + iconCalculatorSvg,
    //   isRequired: outletStockCountCheck,
    //   visitDate: visitDate,
    // ),
    StepModel(
      id: 3,
      outletId: outletId,
      name: AppString.maintenance,
      icon: assetIconsPath + iconSettingSvg,
      isRequired: 0,
      visitDate: visitDate,
    ),
  ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'outletId': outletId,
      'name': name,
      'icon': icon,
      'status': status,
      'isRequired': isRequired,
      'visitDate': visitDate?.typeDate().toString(),
    };
  }

  factory StepModel.generate(Map<String, dynamic> json) => _$StepModelFromJson(json);

}