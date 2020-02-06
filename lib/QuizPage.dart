import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_quiz_app/ResultPage.dart';

class GetJson extends StatelessWidget {
String path;
GetJson({Key key, this.path}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(path),
      builder: (context, snapshot){
        List myData = json.decode(snapshot.data.toString());
        if(myData == null){
          return Scaffold(
            backgroundColor: Colors.indigoAccent,
             body: Center(
               child: Text(
                   "Loading..",
                 style: TextStyle(
                   fontSize: 25.0,
                   fontWeight: FontWeight.w600
                 ),
               ),
             ),
          );
        }else{
          return QuizPage(myData: myData);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  var myData;
  QuizPage({Key key, @required this.myData}): super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(myData);
}

class _QuizPageState extends State<QuizPage> {

  var myData;
  Color colorToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int idx = 1;
  int timer = 30;
  String timeToShow = "30";
  bool cancelTimer = false;
  Map<String, Color> btnColor = {
    "a" : Colors.indigoAccent,
    "b" : Colors.indigoAccent,
    "c" : Colors.indigoAccent,
    "d" : Colors.indigoAccent,
  };

  _QuizPageState(this.myData);

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  void startTimer()async{
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer time){
      setState(() {
        if(timer < 1){
          time.cancel();
          nextQuestion();
        }else if(cancelTimer){
          time.cancel();
          Timer(Duration(seconds: 2), (){
            nextQuestion();
          });
        }else{
          timer--;
          timeToShow = timer.toString();
        }
      });
    });
  }
  void checkAnswer(String opt){
      if(myData[2][idx.toString()] == myData[1][idx.toString()][opt]){
        marks += 10;
        colorToShow = right;
      }else{
        colorToShow = wrong;
      }
      setState(() {
        btnColor[opt] = colorToShow;
        cancelTimer = true;
      });
  }

  void nextQuestion(){
    timer = 30;
    cancelTimer = false;
    setState(() {
      if(idx<5){
        idx++;
        btnColor["a"] = Colors.indigoAccent;
        btnColor["b"] = Colors.indigoAccent;
        btnColor["c"] = Colors.indigoAccent;
        btnColor["d"] = Colors.indigoAccent;
        startTimer();
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks : marks),
        ));
      }
    });
  }

  Widget choiceButton(String opt){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0
      ),
      child: MaterialButton(
        onPressed: () => checkAnswer(opt),
        color: btnColor[opt],
        splashColor: Colors.indigo,
        highlightColor: Colors.indigo,
        minWidth: 200.0,
        height: 50.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: Text(
          myData[1][idx.toString()][opt],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike-Regular",
            fontSize: 16.0
          ),
          maxLines: 1,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
   ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(""
                  "Back???"
              ),
              content: Text(
                "Please complete your quiz."
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                      "Got it",
                  ),
                )
              ],
            ),
        );
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  myData[0][idx.toString()],
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Quando",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choiceButton('a'),
                    choiceButton('b'),
                    choiceButton('c'),
                    choiceButton('d'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  timeToShow,
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Times New Roman"
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

