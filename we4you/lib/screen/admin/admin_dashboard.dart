import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({Key key}) : super(key: key);
  static final routeName = './AdminDashboard';

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(" admin dash board onprogress..."),
      ),
    );
  }
}
