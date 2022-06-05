import 'package:flutter/material.dart';
import 'package:notebook/myHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color:Colors.purple,
      title: 'My Notebook',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

