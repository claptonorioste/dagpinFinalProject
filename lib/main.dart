import 'package:flutter/material.dart';
import 'package:login/authentication.dart';
import 'package:login/root_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Care Here',
        debugShowCheckedModeBanner: false,
        theme:  ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  RootPage(auth:  Auth()));
  }
}