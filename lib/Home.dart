import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'QuizPage.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget customCard(String cardName, int index){

    Map<String, String> paths = {
      "Python" : "assets/python.json",
      "Java" : "assets/java.json",
      "Java Script" : "assets/js.json",
      "C++" : "assets/cpp.json"
    };
    List<String> images = [
      "images/py.png",
      "images/java.png",
      "images/js.png",
      "images/cpp.png",
    ];
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => GetJson(path: paths[cardName]),
          ));
        },
        child: Material(
          color: Colors.indigoAccent,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.contain,
                           image: AssetImage(
                             images[index]
                           ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    cardName,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: "Alike-Regular",
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "This is some description about Python and it contains quizs",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Alike-Regular",
                      color: Colors.white70
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Start Quiz",
          style: TextStyle(
            fontFamily: "Quando"
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customCard("Python", 0),
          customCard("Java", 1),
          customCard("Java Script", 2),
          customCard("C++", 3),
        ],
      )
    );
  }
}
