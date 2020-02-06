import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_app/Home.dart';

class ResultPage extends StatefulWidget {
  int marks;
  ResultPage({Key key, @required this.marks}) : super(key : key);
  @override
  _ResultPageState createState() => _ResultPageState(marks);
}

class _ResultPageState extends State<ResultPage> {
  int marks;
  String img;
  String message;
  List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png"
  ];
  _ResultPageState(this.marks);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(marks == 50){
        img = images[0];
        message = "Congratss..You have scored $marks";
      }else if(marks >= 30 && marks < 50){
        img = images[1];
        message = "You should try once more..You have scored $marks";
      }else{
        img = images[2];
        message = "You need to work harder..You have scored $marks";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result"
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Material(
              elevation: 10,
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Material(
                       child: Container(
                          width: 300.0,
                          height: 300.0,
                          child: ClipRect(
                            child: Image(
                              image: AssetImage(
                                  img
                              ),
                            ),
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Quando",
                            fontStyle: FontStyle.italic,
                            color: Colors.indigoAccent
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home()
                    ));
                  },
                  splashColor: Colors.indigo,
                  highlightColor: Colors.indigo,
                  borderSide: BorderSide(
                    color: Colors.indigoAccent,
                    width: 2.5
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.indigo
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
