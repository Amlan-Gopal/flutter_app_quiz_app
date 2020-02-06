import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_quiz_app/Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home()
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          "Lets Quiz",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 35.0,
            fontStyle: FontStyle.italic,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
