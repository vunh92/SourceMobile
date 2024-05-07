import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'survey_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyModel extends SurveyEntity{
  SurveyModel({
    super.id,
    super.name,
    super.note,
    this.questions = const [],
  });

  List<SurveyQuestionModel> questions;

  factory SurveyModel.fromJson(Map<String, dynamic> json) => _$SurveyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

  factory SurveyModel.mapFromJson(Map<String, dynamic> json) => SurveyModel(
    id: json['ID'] as int? ?? 0,
    name: json['Name'] as String? ?? '',
    note: json['Note'] as String? ?? '',
    questions: (json['Questions'] as List<dynamic>?)
        ?.map((e) =>
        SurveyQuestionModel.fromJsonApi(e as Map<String, dynamic>))
        .toList() ??
        const [],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'note': note,
    };
  }

  factory SurveyModel.generate(Map<String, dynamic> json) => _$SurveyModelFromJson(json);
}
