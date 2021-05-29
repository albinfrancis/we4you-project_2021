import 'package:flutter/material.dart';

class Consultation extends StatefulWidget {
  @override
  _ConsultationState createState() => new _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: new Text('Consultation'),
      ),
    );
  }
}
