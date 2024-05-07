import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'survey_question_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyQuestionModel extends QuestionEntity{
  SurveyQuestionModel({
    super.surveyId,
    super.answer1,
    super.answer2,
    super.answer3,
    super.answer4,
    super.answerType,
    super.isAnswer1Input,
    super.isAnswer2Input,
    super.isAnswer3Input,
    super.isAnswer4Input,
    super.questionId,
    super.questionName,
    super.displayOrder,
    super.status,
    this.uuid = '',
    this.outletId = 0,
    this.answerInput1 = '',
    this.answerInput2 = '',
    this.answerInput3 = '',
    this.answerInput4 = '',
    this.answerText = '',
    this.hotZoneId = '',
  });

  String? uuid;
  int? outletId;
  String? answerInput1;
  String? answerInput2;
  String? answerInput3;
  String? answerInput4;
  String? answerText;
  String? hotZoneId;

  factory SurveyQuestionModel.fromJsonApi(Map<String, dynamic> json) => SurveyQuestionModel(
    uuid: json['uuid'] as String? ?? const Uuid().v1(),
    outletId: json['OutletID'] as int? ?? 0,
    surveyId: json['SurveyID'] as int? ?? 0,
    answer1: json['Answer1'] as String? ?? '',
    answer2: json['Answer2'] as String? ?? '',
    answer3: json['Answer3'] as String? ?? '',
    answer4: json['Answer4'] as String? ?? '',
    answerType: json['AnswerType'] as int? ?? 1,
    isAnswer1Input: json['IsAnswer1Input'] as bool? ?? false,
    isAnswer2Input: json['IsAnswer2Input'] as bool? ?? false,
    isAnswer3Input: json['IsAnswer3Input'] as bool? ?? false,
    isAnswer4Input: json['IsAnswer4Input'] as bool? ?? false,
    questionId: json['ID'] as int? ?? 0,
    questionName: json['Name'] as String? ?? '',
    displayOrder: json['DisplayOrder'] as int? ?? 1,
    status: json['Status'] as int? ?? 1,
    answerInput1: json['AnswerInput1'] as String? ?? '',
    answerInput2: json['AnswerInput2'] as String? ?? '',
    answerInput3: json['AnswerInput3'] as String? ?? '',
    answerInput4: json['AnswerInput4'] as String? ?? '',
    answerText: json['AnswerText'] as String? ?? '',
    hotZoneId: json['HotZoneId'] as String? ?? '',
  );

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'surveyId': surveyId,
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'answer4': answer4,
      'answerType': answerType,
      'isAnswer1Input': isAnswer1Input == true ? 1 : 0,
      'isAnswer2Input': isAnswer2Input == true ? 1 : 0,
      'isAnswer3Input': isAnswer3Input == true ? 1 : 0,
      'isAnswer4Input': isAnswer4Input == true ? 1 : 0,
      'questionId': questionId,
      'questionName': questionName,
      'answerInput1': answerInput1,
      'answerInput2': answerInput2,
      'answerInput3': answerInput3,
      'answerInput4': answerInput4,
      'answerText': answerText,
      'displayOrder': displayOrder,
      'status': status,
      'outletId': outletId,
      'hotZoneId': hotZoneId,
    };
  }

  factory SurveyQuestionModel.generate(Map<String, dynamic> json) => SurveyQuestionModel(
    uuid: json['uuid'] as String? ?? '',
    surveyId: json['surveyId'] as int? ?? 0,
    answer1: json['answer1'] as String? ?? '',
    answer2: json['answer2'] as String? ?? '',
    answer3: json['answer3'] as String? ?? '',
    answer4: json['answer4'] as String? ?? '',
    answerType: json['answerType'] as int? ?? 1,
    isAnswer1Input: (json['isAnswer1Input'] as int?) == 1,
    isAnswer2Input: (json['isAnswer2Input'] as int?) == 1,
    isAnswer3Input: (json['isAnswer3Input'] as int?) == 1,
    isAnswer4Input: (json['isAnswer4Input'] as int?) == 1,
    questionId: json['questionId'] as int? ?? 0,
    questionName: json['questionName'] as String? ?? '',
    displayOrder: json['displayOrder'] as int? ?? 1,
    status: json['status'] as int? ?? 1,
    outletId: json['outletId'] as int? ?? 1,
    answerInput1: json['answerInput1'] as String? ?? '',
    answerInput2: json['answerInput2'] as String? ?? '',
    answerInput3: json['answerInput3'] as String? ?? '',
    answerInput4: json['answerInput4'] as String? ?? '',
    answerText: json['answerText'] as String? ?? '',
    hotZoneId: json['hotZoneId'] as String? ?? '',
  );

  Map<String, String> toBodyCheckOut() {
    return {
      'QuestionID': questionId.toString(),
      'QuestionName': questionName.toString(),
      'QuestionType': answerType.toString(),
      'Answer1Name': answer1.toString(),
      'Answer2Name': answer2.toString(),
      'Answer3Name': answer3.toString(),
      'Answer4Name': answer4.toString(),
      'IsAnswer1': isAnswer1Input.toString(),
      'IsAnswer2': isAnswer2Input.toString(),
      'IsAnswer3': isAnswer3Input.toString(),
      'IsAnswer4': isAnswer4Input.toString(),
      'AnswerInput1': answerInput1.toString(),
      'AnswerInput2': answerInput2.toString(),
      'AnswerInput3': answerInput3.toString(),
      'AnswerInput4': answerInput4.toString(),
      'AnswerText': answerText.toString(),
    };
  }

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) => _$SurveyQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyQuestionModelToJson(this);

}
