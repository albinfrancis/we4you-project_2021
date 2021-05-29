import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:we4you/screen/patient/Ordering/widget/text_recognition_widget.dart';

class Ordering extends StatefulWidget {
  @override
  _OrderingState createState() => new _OrderingState();
}

class _OrderingState extends State<Ordering> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: new Text('Ordering'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextRecognitionWidget(),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
