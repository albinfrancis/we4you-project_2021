import 'package:flutter/material.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmetsState createState() => new _AppointmetsState();
}

class _AppointmetsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: new Text('Appointments'),
      ),
    );
  }
}
