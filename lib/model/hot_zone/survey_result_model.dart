import 'package:json_annotation/json_annotation.dart';

part 'survey_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyResultModel {
  SurveyResultModel({
    this.id,
    this.checkInId,
    this.questionId = 1,
    this.answer1 = '',
    this.answer2 = '',
    this.answer3 = '',
    this.answer4 = '',
    this.answerType = 1,
    this.isAnswer1Input = false,
    this.isAnswer2Input = false,
    this.isAnswer3Input = false,
    this.isAnswer4Input = false,
    this.name = '',
    this.displayOrder = 1,
    this.status = 1,
    this.text = '',
  });

  String? id;
  int? checkInId;
  int? questionId;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  int? answerType;
  bool? isAnswer1Input;
  bool? isAnswer2Input;
  bool? isAnswer3Input;
  bool? isAnswer4Input;
  String? name;
  int? displayOrder;
  int? status;
  String? text;

  factory SurveyResultModel.fromJson(Map<String, dynamic> json) => _$SurveyResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResultModelToJson(this);
}
