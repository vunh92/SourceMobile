import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'hot_zone_response.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionRequest {
  QuestionRequest({
    this.questionId = 0,
    this.questionName = '',
    this.questionType = '',
    this.answerType = 1,
    this.answer1Name = '',
    this.answer2Name = '',
    this.answer3Name = '',
    this.answer4Name = '',
    this.isAnswer1 = false,
    this.isAnswer2 = false,
    this.isAnswer3 = false,
    this.isAnswer4 = false,
    this.answerInput1 = false,
    this.answerInput2 = false,
    this.answerInput3 = false,
    this.answerInput4 = false,
    this.answerText = '',
  });

  int? questionId;
  String? questionName;
  String? questionType;
  int? answerType;
  String? answer1Name;
  String? answer2Name;
  String? answer3Name;
  String? answer4Name;
  bool? isAnswer1;
  bool? isAnswer2;
  bool? isAnswer3;
  bool? isAnswer4;
  bool? answerInput1;
  bool? answerInput2;
  bool? answerInput3;
  bool? answerInput4;
  String? answerText;

  factory QuestionRequest.mapFromJson(Map<String, dynamic> json) => QuestionRequest(
    questionId: json['QuestionId'] as int? ?? 0,
    questionName: json['QuestionName'] as String? ?? '',
    questionType: json['QuestionType'] as String? ?? '',
    answerType: json['AnswerType'] as int? ?? 1,
    answer1Name: json['Answer1Name'] as String? ?? '',
    answer2Name: json['Answer2Name'] as String? ?? '',
    answer3Name: json['Answer3Name'] as String? ?? '',
    answer4Name: json['Answer4Name'] as String? ?? '',
    isAnswer1: json['IsAnswer1'] as bool? ?? false,
    isAnswer2: json['IsAnswer2'] as bool? ?? false,
    isAnswer3: json['IsAnswer3'] as bool? ?? false,
    isAnswer4: json['IsAnswer4'] as bool? ?? false,
    answerInput1: json['AnswerInput1'] as bool? ?? false,
    answerInput2: json['AnswerInput2'] as bool? ?? false,
    answerInput3: json['AnswerInput3'] as bool? ?? false,
    answerInput4: json['AnswerInput4'] as bool? ?? false,
    answerText: json['AnswerText'] as String? ?? '',
  );

  Map<String, dynamic> toMapCheckOutBody() =>  <String, dynamic>{
    'QuestionId': questionId,
    'QuestionName': questionName,
    'QuestionType': questionType,
    'AnswerType': answerType,
    'Answer1Name': answer1Name,
    'Answer2Name': answer2Name,
    'Answer3Name': answer3Name,
    'Answer4Name': answer4Name,
    'IsAnswer1': isAnswer1,
    'IsAnswer2': isAnswer2,
    'IsAnswer3': isAnswer3,
    'IsAnswer4': isAnswer4,
    'AnswerInput1': answerInput1,
    'AnswerInput2': answerInput2,
    'AnswerInput3': answerInput3,
    'AnswerInput4': answerInput4,
    'AnswerText': answerText,
  };

  factory QuestionRequest.mapFromQuestion({required SurveyQuestionModel questionModel}) => QuestionRequest(
    questionId: questionModel.questionId,
    questionName: questionModel.questionName,
    questionType: questionModel.answerType.toString(),
    answerType: questionModel.answerType,
    answer1Name: questionModel.answer1,
    answer2Name: questionModel.answer2,
    answer3Name: questionModel.answer3,
    answer4Name: questionModel.answer4,
    isAnswer1: questionModel.isAnswer1Input,
    isAnswer2: questionModel.isAnswer2Input,
    isAnswer3: questionModel.isAnswer3Input,
    isAnswer4: questionModel.isAnswer4Input,
    answerInput1: questionModel.isAnswer1Input,
    answerInput2: questionModel.isAnswer2Input,
    answerInput3: questionModel.isAnswer3Input,
    answerInput4: questionModel.isAnswer4Input,
    answerText: questionModel.answerText,
  );

  factory QuestionRequest.fromJson(Map<String, dynamic> json) => _$QuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionRequestToJson(this);

}
