// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map<String, dynamic> json) => SurveyModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      note: json['note'] as String? ?? '',
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) =>
                  SurveyQuestionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SurveyModelToJson(SurveyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
