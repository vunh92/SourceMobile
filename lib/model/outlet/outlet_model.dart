import 'package:cooler_mdlz/app/utlis/utils.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'outlet_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OutletModel extends OutletEntity{


  OutletModel({
    super.id,
    super.code,
    super.name,
    super.nameNormalize,
    super.phone,
    super.lat,
    super.long,
    super.location1,
    super.location2,
    super.location3,
    super.location4,
    super.hotZonePicture,
    super.outletPicture,
    super.note,
    super.status,
    super.checkInDate,
    super.checkInTime,
    super.currentStatus,
    super.coolerStatus,
    super.checkInId,
    super.checkOutDate,
    super.checkOutTime,
    super.countCheckoutSuccess,
    super.surveyId,
    super.checkOutStatus,
    this.address = '',
    this.distance = 0,

    this.checkListData,

  });

  String? address = '';
  double? distance = 0;
  List<OutletCheckOutResponse>? checkListData;

  factory OutletModel.fromJsonApi(Map<String, dynamic> json) => OutletModel(
    id: json['ID'] as int? ?? 0,
    code: json['Code'] as String? ?? '',
    name: json['Name'] as String? ?? '',
    nameNormalize: json['NameNormalize'] as String? ?? '',
    phone: json['Phone'] as String? ?? '',
    lat: double.parse(json['Lat'] as String? ?? '0'),
    long: double.parse(json['Long'] as String? ?? '0'),
    location1: json['Location1'] as String? ?? '',
    location2: json['Location2'] as String? ?? '',
    location3: json['Location3'] as String? ?? '',
    location4: json['Location4'] as String? ?? '',
    hotZonePicture: json['HotZonePicture'] as String? ?? '',
    outletPicture: json['OutletPicture'] as String? ?? '',
    note: json['Note'] as String? ?? '',
    status: json['Status'] as int? ?? 1,
    checkInDate: json['CheckInDate'] == null
        ? null
        : DateTime.parse(json['CheckInDate'] as String),
    checkInTime: json['CheckInTime'] as String? ?? '',
    currentStatus: json['CurrentStatus'] as String? ?? '',
    coolerStatus: json['CoolerStatus'] as String? ?? '',
    checkOutStatus: json['CheckOutStatus'] as int? ?? 0,
    checkInId: json['CheckInID'] as String? ?? '',
    checkOutDate: json['CheckOutDate'] == null
        ? null
        : DateTime.parse(json['CheckOutDate'] as String),
    checkOutTime: json['CheckOutTime'] as String? ?? '',
    countCheckoutSuccess: json['CountCheckoutSuccess'] as int? ?? 0,
    surveyId: json['SurveyID'] as int? ?? 0,
    address: Utils.getAddress(
      location1:  json['Location1'] as String? ?? '',
      location2:  json['Location2'] as String? ?? '',
      location3:  json['Location3'] as String? ?? '',
      location4:  json['Location4'] as String? ?? '',
    ),
    distance: (json['Distance'] as num?)?.toDouble() ?? 0,
    checkListData: (json['CheckListData'] as List<dynamic>?)
        ?.map(
            (e) => OutletCheckOutResponse.fromJsonApi(e as Map<String, dynamic>))
        .toList(),
  );

  factory OutletModel.fromJson(Map<String, dynamic> json) => _$OutletModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutletModelToJson(this);
}
