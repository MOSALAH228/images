import 'package:flutter/material.dart';
import 'package:wa_photos/constants/my_colos.dart';
import 'package:wa_photos/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner App',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),

      home: MyHomePage(),
    );
  }
}
