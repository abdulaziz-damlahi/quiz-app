import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';
import 'question.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
  ];

  void emptyScoreKeeper() {
    scoreKeeper.clear();
  }

  List<Question> questionbank = [
    Question(q: 'A slug\'s blood is green.', a: false),
    Question(
        q: 'Approximately one quarter of human bones are in the feet.',
        a: false),
    Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
  ];

  int counter = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Finished!",
          desc: "Try again if you dare...",
          buttons: [
            DialogButton(
                child: Text(
                  "Try again",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                  Navigator.pop(context);
                  setState(() {
                    quizBrain.reset();
                    emptyScoreKeeper();
                  });
                })
          ],
        ).show();
      }

      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionbank[counter].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool correctAnswer = questionbank[counter].questionAnswer;
                if (correctAnswer == true) {
                  print('user git it right');
                } else {
                  print('they got it right');
                }
                setState(() {
                  counter++;
                });
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  counter++;
                });

                scoreKeeper.add(
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
