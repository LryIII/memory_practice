import 'package:flutter/material.dart';
import 'package:memory_practice/pages/home/home_content.dart';
import 'package:memory_practice/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute:onGenerateRoute,
      home: HomeContent(),
    );
  }
}