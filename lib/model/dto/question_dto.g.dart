// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResultResponse _$SurveyResultResponseFromJson(
        Map<String, dynamic> json) =>
    SurveyResultResponse(
      id: json['id'] as int? ?? 0,
      companyId: json['companyId'] as int? ?? 0,
      coolerCheckoutId: json['coolerCheckoutId'] as int? ?? 0,
      questionId: json['questionId'] as String? ?? '',
      questionName: json['questionName'] as String? ?? '',
      questionType: json['questionType'] as int? ?? 0,
      answer1Name: json['answer1Name'] as String? ?? '',
      answer2Name: json['answer2Name'] as String? ?? '',
      answer3Name: json['answer3Name'] as String? ?? '',
      answer4Name: json['answer4Name'] as String? ?? '',
      isAnswer1: json['isAnswer1'] as bool? ?? false,
      isAnswer2: json['isAnswer2'] as bool? ?? false,
      isAnswer3: json['isAnswer3'] as bool? ?? false,
      isAnswer4: json['isAnswer4'] as bool? ?? false,
      answerInput1: json['answerInput1'] as String? ?? '',
      answerInput2: json['answerInput2'] as String? ?? '',
      answerInput3: json['answerInput3'] as String? ?? '',
      answerInput4: json['answerInput4'] as String? ?? '',
      answerText: json['answerText'] as String? ?? '',
      isCaching: json['isCaching'] as bool? ?? true,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      createBy: json['createBy'] as String? ?? '',
      createbyName: json['createbyName'] as String? ?? '',
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      lastUpdateBy: json['lastUpdateBy'] as String? ?? '',
      lastUpdateByName: json['lastUpdateByName'] as String? ?? '',
      lastUpdateDate: json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String),
      actionType: json['actionType'] as int? ?? 0,
    );

Map<String, dynamic> _$SurveyResultResponseToJson(
        SurveyResultResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'coolerCheckoutId': instance.coolerCheckoutId,
      'questionId': instance.questionId,
      'questionName': instance.questionName,
      'questionType': instance.questionType,
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
      'isCaching': instance.isCaching,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'createBy': instance.createBy,
      'createbyName': instance.createbyName,
      'createDate': instance.createDate?.toIso8601String(),
      'lastUpdateBy': instance.lastUpdateBy,
      'lastUpdateByName': instance.lastUpdateByName,
      'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
      'actionType': instance.actionType,
    };
