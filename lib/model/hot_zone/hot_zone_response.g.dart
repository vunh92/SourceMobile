// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_zone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionRequest _$QuestionRequestFromJson(Map<String, dynamic> json) =>
    QuestionRequest(
      questionId: json['questionId'] as int? ?? 0,
      questionName: json['questionName'] as String? ?? '',
      questionType: json['questionType'] as String? ?? '',
      answerType: json['answerType'] as int? ?? 1,
      answer1Name: json['answer1Name'] as String? ?? '',
      answer2Name: json['answer2Name'] as String? ?? '',
      answer3Name: json['answer3Name'] as String? ?? '',
      answer4Name: json['answer4Name'] as String? ?? '',
      isAnswer1: json['isAnswer1'] as bool? ?? false,
      isAnswer2: json['isAnswer2'] as bool? ?? false,
      isAnswer3: json['isAnswer3'] as bool? ?? false,
      isAnswer4: json['isAnswer4'] as bool? ?? false,
      answerInput1: json['answerInput1'] as bool? ?? false,
      answerInput2: json['answerInput2'] as bool? ?? false,
      answerInput3: json['answerInput3'] as bool? ?? false,
      answerInput4: json['answerInput4'] as bool? ?? false,
      answerText: json['answerText'] as String? ?? '',
    );

Map<String, dynamic> _$QuestionRequestToJson(QuestionRequest instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'questionName': instance.questionName,
      'questionType': instance.questionType,
      'answerType': instance.answerType,
      'answer1Name': instance.answer1Name,
      'answer2Name': instance.answer2Name,
      'answer3Name': instance.answer3Name,
      'answer4Name': instance.answer4Name,
      'isAnswer1': instance.isAnswer1,
      'isAnswer2': instance.isAnswer2,
      'isAnswer3': instance.isAnswer3,
      'isAnswer4': instance.isAnswer4,
      'answerInput1': instance.answerInput1,
      'answerInput2': instance.answerInput2,
      'answerInput3': instance.answerInput3,
      'answerInput4': instance.answerInput4,
      'answerText': instance.answerText,
    };
