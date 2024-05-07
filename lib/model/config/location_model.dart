import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationModel{
  LocationModel({
    this.lat = 0,
    this.long = 0,
  });

  double? lat;
  double? long;

  factory LocationModel.fromJsonApi(Map<String, dynamic> json) => LocationModel(
    lat: (json['Lat'] as num?)?.toDouble() ?? 0,
    long: (json['Long'] as num?)?.toDouble() ?? 0,
  );

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}