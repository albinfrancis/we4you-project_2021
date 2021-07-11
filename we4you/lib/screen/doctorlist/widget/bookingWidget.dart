import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:we4you/modelz/patient.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/styles.dart';
import 'package:we4you/utils/toast_widget.dart';

class BookinWidget extends StatefulWidget {
  final PatientModel p;

  const BookinWidget({
    Key key,
    this.p,
  }) : super(key: key);

  @override
  _BookinWidgetState createState() => _BookinWidgetState();
}

class _BookinWidgetState extends State<BookinWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
      ),
      child: InkWell(
        onTap: () {},
        child: Ink(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('Dr ${widget.p.doctorName}',
                                style: ktCaption),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: widget.p.status == 'pending'
                                  ? kcLightOrange
                                  : kcLightTurquoice,
                            ),
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 2, bottom: 2),
                            margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                            child: Center(
                              child: Text(
                                widget.p.status,
                                style: TextStyle(
                                    color: widget.p.status == 'pending'
                                        ? kcOrange
                                        : kcTurquoice,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text('Booking date ${widget.p.date}',
                          style: ktBody2.copyWith(color: kcTextLight)),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: kcTextLight,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
