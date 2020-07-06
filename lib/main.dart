import 'package:flutter/material.dart';

import 'package:etechapp/UI/Login.dart';
import 'package:etechapp/UI/test.dart';

import 'UI/Initial.dart';

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
