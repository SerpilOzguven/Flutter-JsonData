import 'package:flutter/material.dart';
import 'package:json_veritabani_uygulama/il.dart';
import 'package:json_veritabani_uygulama/iller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Iller(),
    );
  }
}
