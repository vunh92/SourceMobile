abstract class QuestionEntity {
  QuestionEntity({
    this.surveyId = 0,
    this.answer1 = '',
    this.answer2 = '',
    this.answer3 = '',
    this.answer4 = '',
    this.answerType = 1,
    this.isAnswer1Input = false,
    this.isAnswer2Input = false,
    this.isAnswer3Input = false,
    this.isAnswer4Input = false,
    this.questionId = 0,
    this.questionName = '',
    this.displayOrder = 1,
    this.status = 1,
  });

  int? surveyId;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  int? answerType;
  bool? isAnswer1Input;
  bool? isAnswer2Input;
  bool? isAnswer3Input;
  bool? isAnswer4Input;
  String? questionName;
  int? questionId;
  int? displayOrder;
  int? status;
}
