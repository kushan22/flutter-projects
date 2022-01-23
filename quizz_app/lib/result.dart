import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function resetQuiz;
  final int totalScore;

  Result(this.resetQuiz, this.totalScore);

  String get resultPhrase {
    var resultText;
    if (totalScore <= 8) {
      resultText = "You failed!";
    } else if (totalScore <= 12) {
      resultText = "pretty likeable";
    } else if (totalScore <= 16) {
      resultText = "You are strange!";
    } else {
      resultText = "You are bad!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetQuiz,
            child: Text("Reset Quiz"),
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
