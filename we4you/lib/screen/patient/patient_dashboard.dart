import 'package:flutter/material.dart';

class PatientDashboard extends StatefulWidget {
  PatientDashboard({Key key}) : super(key: key);
  static final routeName = './PatientDashboard';

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("patient dash board onprogress..."),
      ),
    );
  }
}
