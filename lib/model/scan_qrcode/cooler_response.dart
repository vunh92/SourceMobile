import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'cooler_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CoolerResponse {
  CoolerResponse({
    this.coolers = const [],
  });

  List<CoolerModel> coolers;

  factory CoolerResponse.mapFromJson(List<dynamic>? json) => CoolerResponse(
    coolers: json
        ?.map((e) => CoolerModel.mapFromJson(e as Map<String, dynamic>))
        .toList() ??
        const [],
  );

  Map<String, dynamic> toJson() => _$CoolerResponseToJson(this);
}
