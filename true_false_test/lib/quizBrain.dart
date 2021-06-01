import 'Question.dart';

class QuizBrain {
  List<Question> _myquestions = [
    Question( 'Treasure has 12 formal members',  true),
    Question( 'Canada is the biggest country by land',  false),
    Question( 'HTML is a programming language',  false),
    Question( 'There are 3 main colors',  true),
    Question(
         'Trumb and Biden are both had experience being president of USA',
         true),
  ];

  String getText(int index){
    return _myquestions[index].questionText;
  }
  bool getAnswer(int index){
    return _myquestions[index].answer;
  }

}
