import 'package:flutter/material.dart';

import './src/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We4you Panel',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: IndexPage(),
    );
  }
}
