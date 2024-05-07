import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'question_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyResultResponse {
  SurveyResultResponse({
    this.id = 0,
    this.companyId = 0,
    this.coolerCheckoutId = 0,
    this.questionId = '',
    this.questionName = '',
    this.questionType = 0,
    this.answer1Name = '',
    this.answer2Name = '',
    this.answer3Name = '',
    this.answer4Name = '',
    this.isAnswer1 = false,
    this.isAnswer2 = false,
    this.isAnswer3 = false,
    this.isAnswer4 = false,
    this.answerInput1 = '',
    this.answerInput2 = '',
    this.answerInput3 = '',
    this.answerInput4 = '',
    this.answerText = '',
    this.isCaching = true,
    this.title = '',
    this.description = '',
    this.status = 0,
    this.createBy = '',
    this.createbyName = '',
    this.createDate,
    this.lastUpdateBy = '',
    this.lastUpdateByName = '',
    this.lastUpdateDate,
    this.actionType = 0,
  });

  int? id;
  int? companyId;
  int? coolerCheckoutId;
  String? questionId;
  String? questionName;
  int? questionType;
  String? answer1Name;
  String? answer2Name;
  String? answer3Name;
  String? answer4Name;
  bool? isAnswer1;
  bool? isAnswer2;
  bool? isAnswer3;
  bool? isAnswer4;
  String? answerInput1;
  String? answerInput2;
  String? answerInput3;
  String? answerInput4;
  String? answerText;
  bool? isCaching;
  String? title;
  String? description;
  int? status;
  String? createBy;
  String? createbyName;
  DateTime? createDate;
  String? lastUpdateBy;
  String? lastUpdateByName;
  DateTime? lastUpdateDate;
  int? actionType;

  factory SurveyResultResponse.fromJsonApi(Map<String, dynamic> json) => SurveyResultResponse(
    id: json['ID'] as int? ?? 0,
    companyId: json['CompanyID'] as int? ?? 0,
    coolerCheckoutId: json['CoolerCheckoutID'] as int? ?? 0,
    questionId: json['QuestionID'] as String? ?? '',
    questionName: json['QuestionName'] as String? ?? '',
    questionType: json['QuestionType'] as int? ?? 0,
    answer1Name: json['Answer1Name'] as String? ?? '',
    answer2Name: json['Answer2Name'] as String? ?? '',
    answer3Name: json['Answer3Name'] as String? ?? '',
    answer4Name: json['Answer4Name'] as String? ?? '',
    isAnswer1: json['IsAnswer1'] as bool? ?? false,
    isAnswer2: json['IsAnswer2'] as bool? ?? false,
    isAnswer3: json['IsAnswer3'] as bool? ?? false,
    isAnswer4: json['IsAnswer4'] as bool? ?? false,
    answerInput1: json['AnswerInput1'] as String? ?? '',
    answerInput2: json['AnswerInput2'] as String? ?? '',
    answerInput3: json['AnswerInput3'] as String? ?? '',
    answerInput4: json['AnswerInput4'] as String? ?? '',
    answerText: json['AnswerText'] as String? ?? '',
    isCaching: json['IsCaching'] as bool? ?? true,
    title: json['Title'] as String? ?? '',
    description: json['Description'] as String? ?? '',
    status: json['Status'] as int? ?? 0,
    createBy: json['CreateBy'] as String? ?? '',
    createbyName: json['CreatebyName'] as String? ?? '',
    createDate: json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String),
    lastUpdateBy: json['LastUpdateBy'] as String? ?? '',
    lastUpdateByName: json['LastUpdateByName'] as String? ?? '',
    lastUpdateDate: json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String),
    actionType: json['ActionType'] as int? ?? 0,
  );

  factory SurveyResultResponse.fromJson(Map<String, dynamic> json) => _$SurveyResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResultResponseToJson(this);

  SurveyQuestionModel mapSurveyQuestionModel({
    required int outletId,
    required int surveyId,
    required int displayOrder,
  }) => SurveyQuestionModel(
    uuid: const Uuid().v1(),
    outletId: outletId,
    surveyId: surveyId,
    answer1: answer1Name,
    answer2: answer2Name,
    answer3: answer3Name,
    answer4: answer4Name,
    answerType: questionType,
    isAnswer1Input: isAnswer1,
    isAnswer2Input: isAnswer2,
    isAnswer3Input: isAnswer3,
    isAnswer4Input: isAnswer4,
    questionId: int.parse(questionId ?? '0'),
    questionName: questionName,
    displayOrder: displayOrder,
    status: status,
    answerText: answerText,
  );

}