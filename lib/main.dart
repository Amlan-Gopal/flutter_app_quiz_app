import 'package:flutter/material.dart';
import 'SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SplashScreen(),
    );
  }
}

