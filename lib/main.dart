import 'package:flutter/material.dart';

import 'package:resturant_app/UI/Login.dart';
import 'package:resturant_app/UI/test.dart';

import 'UI/Food.dart';

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

        home:LoginScreen());
  }
}
