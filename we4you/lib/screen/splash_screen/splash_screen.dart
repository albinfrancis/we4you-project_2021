import 'dart:async';
import 'package:flutter/material.dart';
import 'package:we4you/screen/dash_board/dash_board.dart';
import 'package:we4you/screen/login_dashboard.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);
  static final routeName = './SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  getData() async {
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginDashboard()),
          (Route<dynamic> route) => false);
    });
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    if (i == 0) {
      getData();
    }
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Image.asset(
              'we.png',
              height: 150,
              width: 200,
            )),
            Text("Loading......")
          ],
        ));
  }
}
