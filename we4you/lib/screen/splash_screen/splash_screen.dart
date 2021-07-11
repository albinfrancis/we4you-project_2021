import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/screen/admin/admin_dashboard.dart';
import 'package:we4you/screen/dash_board/dash_board.dart';
import 'package:we4you/screen/doctor/doctor_dashboard.dart';
import 'package:we4you/screen/login_dashboard.dart';
import 'package:we4you/screen/patient/patient_dashboard.dart';
import 'package:we4you/screen/pharmacy/pharmacy_dashboard.dart';

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
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getString('username') == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginDashboard()),
            (Route<dynamic> route) => false);
      } else {
        String usertype = prefs.getString('usertype');
        if (usertype == 'admin') {
          Navigator.of(context).pushReplacementNamed(AdminDashboard.routeName);
        } else if (usertype == 'doctor') {
          Navigator.of(context).pushReplacementNamed(DoctorDashboard.routeName);
        } else if (usertype == 'pharmacy') {
          Navigator.of(context)
              .pushReplacementNamed(PharmacyDashboard.routeName);
        } else {
          Navigator.of(context)
              .pushReplacementNamed(PatientDashboard.routeName);
        }
      }
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
