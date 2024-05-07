// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyQuestionModel _$SurveyQuestionModelFromJson(Map<String, dynamic> json) =>
    SurveyQuestionModel(
      surveyId: json['surveyId'] as int? ?? 0,
      answer1: json['answer1'] as String? ?? '',
      answer2: json['answer2'] as String? ?? '',
      answer3: json['answer3'] as String? ?? '',
      answer4: json['answer4'] as String? ?? '',
      answerType: json['answerType'] as int? ?? 1,
      isAnswer1Input: json['isAnswer1Input'] as bool? ?? false,
      isAnswer2Input: json['isAnswer2Input'] as bool? ?? false,
      isAnswer3Input: json['isAnswer3Input'] as bool? ?? false,
      isAnswer4Input: json['isAnswer4Input'] as bool? ?? false,
      questionId: json['questionId'] as int? ?? 0,
      questionName: json['questionName'] as String? ?? '',
      displayOrder: json['displayOrder'] as int? ?? 1,
      status: json['status'] as int? ?? 1,
      uuid: json['uuid'] as String? ?? '',
      outletId: json['outletId'] as int? ?? 0,
      answerInput1: json['answerInput1'] as String? ?? '',
      answerInput2: json['answerInput2'] as String? ?? '',
      answerInput3: json['answerInput3'] as String? ?? '',
      answerInput4: json['answerInput4'] as String? ?? '',
      answerText: json['answerText'] as String? ?? '',
      hotZoneId: json['hotZoneId'] as String? ?? '',
    );

Map<String, dynamic> _$SurveyQuestionModelToJson(
        SurveyQuestionModel instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'answer1': instance.answer1,
      'answer2': instance.answer2,
      'answer3': instance.answer3,
      'answer4': instance.answer4,
      'answerType': instance.answerType,
      'isAnswer1Input': instance.isAnswer1Input,
      'isAnswer2Input': instance.isAnswer2Input,
      'isAnswer3Input': instance.isAnswer3Input,
      'isAnswer4Input': instance.isAnswer4Input,
      'questionName': instance.questionName,
      'questionId': instance.questionId,
      'displayOrder': instance.displayOrder,
      'status': instance.status,
      'uuid': instance.uuid,
      'outletId': instance.outletId,
      'answerInput1': instance.answerInput1,
      'answerInput2': instance.answerInput2,
      'answerInput3': instance.answerInput3,
      'answerInput4': instance.answerInput4,
      'answerText': instance.answerText,
      'hotZoneId': instance.hotZoneId,
    };
