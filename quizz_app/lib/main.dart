import 'package:flutter/material.dart';
import 'package:quizz_app/result.dart';
import './question.dart';
import './answer.dart';
import './quiz.dart';

void main() {
  runApp(QuizzApp());
}

class QuizzApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuizAppState();
  }
}

class _QuizAppState extends State<QuizzApp> {
  final _questions = const [
    {
      "questionText": "What is your favorite color ?",
      "answers": [
        {"text": "White", "score": 10},
        {"text": "Black", "score": 5},
        {"text": "Blue", "score": 8},
        {"text": "Green", "score": 6}
      ],
    },
    {
      "questionText": "What is your favorite animal ?",
      "answers": [
        {"text": "Cheetah", "score": 10},
        {"text": "Lion", "score": 8},
        {"text": "Cow", "score": 5},
        {"text": "Monkey", "score": 4},
      ],
    },
    {
      "questionText": "who is your favorite cricketer ?",
      "answers": [
        {"text": "Kohli", "score": 10},
        {"text": "Smith", "score": 8},
        {"text": "Williamson", "score": 7},
        {"text": "Maxwell", "score": 5}
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalscore = 0;
  void _answerQuestion(int score) {
    _totalscore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    }); // Changing any state comes under setState() function which take an anonymous functuion as argument

    //  print(questionIndex);
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalscore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Quizz App"),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(_resetQuiz, _totalscore),
    ));
  }
}
