import 'package:flutter/material.dart';
import 'package:quizzler/brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  List<Icon> answerBar = [];

  void showAlert(BuildContext context) {
    Alert(
      context: context,
      title: 'Congratulations',
      desc: 'You have completed the quiz.',
    ).show();
    Brain.resetQues();
    answerBar = [];
  }

  Icon getIcons(bool ans) {
    bool res = Brain.answerCheck(ans);
    Color c;
    dynamic i;
    if (res) {
      c = Colors.green;
      i = Icons.check;
    } else {
      c = Colors.red;
      i = Icons.clear;
    }

    return Icon(
      i,
      color: c,
    );
  }

  void onAnswerClickListener(bool b) {
    setState(() {
      if (Brain.getQuesNumber() == Brain.totalQues() - 1) {
        showAlert(context);
      } else {
        answerBar.add(getIcons(b));
      }
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
                (Brain.getQuesNumber() + 1).toString() +
                    ' . ' +
                    Brain.getQuest(),
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
                //The user picked true.
                onAnswerClickListener(true);
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
                //The user picked false.
                onAnswerClickListener(false);
              },
            ),
          ),
        ),
        Row(
          children: answerBar,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
