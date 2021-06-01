import 'package:flutter/material.dart';
import 'dart:math';
import 'quizBrain.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain brain = QuizBrain();

void main() {
  runApp(TrueOrFalse());
}

class TrueOrFalse extends StatelessWidget {
  const TrueOrFalse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKepper = [];
  int queationIndex = Random().nextInt(4) + 1;
  AudioCache player = AudioCache();
  int questionCounter = 1;

  void checkAnswer(bool userAnswer) {
    if (brain.getAnswer(queationIndex) == userAnswer) {
      print("true");

      if (questionCounter <= 5) {
        player.play('correct.mp3');
        scoreKepper.add(
          Icon(
            Icons.check,
            color: Colors.green.shade200,
          ),
        );
      } else
        Alert(
                context: context,
                title: "Random Quiz finished",
                desc: " You have answered 5 questions")
            .show();
    } else {
      print(false);
      if (questionCounter <= 5) {
        scoreKepper.add(
          Icon(
            Icons.close,
            color: Colors.red.shade200,
          ),
        );
        player.play('false.mp3');
      } else
        Alert(
                context: context,
                title: "Random Quiz finished",
                desc: " You have answered 5 questions")
            .show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          //color: Colors[colorindex],
          color: Colors.orange.shade100,
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Text(
              brain.getText(queationIndex),
            ),
          ),
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.green.shade200,
              height: 100,
              width: 200,
              child: FlatButton(
                child: Text(
                  'True',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                  setState(() {
                    if (questionCounter <= 5) {
                      queationIndex = Random().nextInt(5);
                      questionCounter++;
                    } else {
                      questionCounter = 0;
                      scoreKepper.clear();
                    }
                  });
                },
              ),
            ),
            Container(
              color: Colors.red.shade200,
              height: 100,
              width: 200,
              child: FlatButton(
                child: Text(
                  'False',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  checkAnswer(false);
                  setState(() {
                    if (questionCounter <= 5) {
                      queationIndex = Random().nextInt(5);
                      questionCounter++;
                    } else {
                      questionCounter = 0;
                      scoreKepper.clear();
                    }
                    // colorindex= Random().nextInt(100);
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: scoreKepper,
        ),
      ],
    );
  }
}
