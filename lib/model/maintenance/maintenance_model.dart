import 'package:cooler_mdlz/common/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities/maintenance_entity.dart';

part 'maintenance_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MaintenanceModel extends MaintenanceEntity{
  MaintenanceModel({
    super.maintenancePicture1 = '',
    super.maintenancePicture2 = '',
    super.maintenancePicture3 = '',
    super.description = '',
    this.uuid = '',
    this.outletId = 0,
    this.maintenancePicture1Local = '',
    this.maintenancePicture2Local = '',
    this.maintenancePicture3Local = '',
    this.completedTime,
    this.visitDate,
  });

  String? uuid;
  int? outletId;
  String? maintenancePicture1Local;
  String? maintenancePicture2Local;
  String? maintenancePicture3Local;
  DateTime? completedTime;
  DateTime? visitDate;

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) => _$MaintenanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceModelToJson(this);

  factory MaintenanceModel.bindingData({required int outletId}) => MaintenanceModel(
    uuid: const Uuid().v1(),
    outletId: outletId,
    maintenancePicture1: '',
    maintenancePicture2: '',
    maintenancePicture3: '',
    maintenancePicture1Local: '',
    maintenancePicture2Local: '',
    maintenancePicture3Local: '',
    description: '',
    completedTime: null,
    visitDate: null,
  );

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'outletId': outletId,
      'maintenancePicture1': maintenancePicture1,
      'maintenancePicture2': maintenancePicture2,
      'maintenancePicture3': maintenancePicture3,
      'maintenancePicture1Local': maintenancePicture1Local,
      'maintenancePicture2Local': maintenancePicture2Local,
      'maintenancePicture3Local': maintenancePicture3Local,
      'description': description,
      'completedTime': completedTime?.typeDate().toString(),
      'visitDate': visitDate?.typeDate().toString(),
    };
  }

  factory MaintenanceModel.generate(Map<String, dynamic> json) => MaintenanceModel(
    uuid: json['uuid'] as String?,
    outletId: json['outletId'] as int?,
    maintenancePicture1: json['maintenancePicture1'] as String? ?? '',
    maintenancePicture2: json['maintenancePicture2'] as String? ?? '',
    maintenancePicture3: json['maintenancePicture3'] as String? ?? '',
    maintenancePicture1Local: json['maintenancePicture1Local'] as String? ?? '',
    maintenancePicture2Local: json['maintenancePicture2Local'] as String? ?? '',
    maintenancePicture3Local: json['maintenancePicture3Local'] as String? ?? '',
    description: json['description'] as String? ?? '',
    completedTime: json['completedTime'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
    visitDate: json['visitDate'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
  );

}
