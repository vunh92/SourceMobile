// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResultModel _$SurveyResultModelFromJson(Map<String, dynamic> json) =>
    SurveyResultModel(
      id: json['id'] as String?,
      checkInId: json['checkInId'] as int?,
      questionId: json['questionId'] as int? ?? 1,
      answer1: json['answer1'] as String? ?? '',
      answer2: json['answer2'] as String? ?? '',
      answer3: json['answer3'] as String? ?? '',
      answer4: json['answer4'] as String? ?? '',
      answerType: json['answerType'] as int? ?? 1,
      isAnswer1Input: json['isAnswer1Input'] as bool? ?? false,
      isAnswer2Input: json['isAnswer2Input'] as bool? ?? false,
      isAnswer3Input: json['isAnswer3Input'] as bool? ?? false,
      isAnswer4Input: json['isAnswer4Input'] as bool? ?? false,
      name: json['name'] as String? ?? '',
      displayOrder: json['displayOrder'] as int? ?? 1,
      status: json['status'] as int? ?? 1,
      text: json['text'] as String? ?? '',
    );

Map<String, dynamic> _$SurveyResultModelToJson(SurveyResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checkInId': instance.checkInId,
      'questionId': instance.questionId,
      'answer1': instance.answer1,
      'answer2': instance.answer2,
      'answer3': instance.answer3,
      'answer4': instance.answer4,
      'answerType': instance.answerType,
      'isAnswer1Input': instance.isAnswer1Input,
      'isAnswer2Input': instance.isAnswer2Input,
      'isAnswer3Input': instance.isAnswer3Input,
      'isAnswer4Input': instance.isAnswer4Input,
      'name': instance.name,
      'displayOrder': instance.displayOrder,
      'status': instance.status,
      'text': instance.text,
    };
