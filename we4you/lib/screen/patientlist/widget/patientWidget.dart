import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:we4you/modelz/patient.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/styles.dart';
import 'package:we4you/utils/toast_widget.dart';

class PatientWidget extends StatefulWidget {
  final PatientModel p;

  const PatientWidget({
    Key key,
    this.p,
  }) : super(key: key);

  @override
  _PatientWidgetState createState() => _PatientWidgetState();
}

class _PatientWidgetState extends State<PatientWidget> {
  @override
  Widget build(BuildContext context) {
    accepttask() async {
      print('-----------------------');
      print(widget.p.pid);
      setState(() {
        widget.p.status = 'loading';
      });
      FirebaseFirestore.instance
          .collection('bookingTable')
          .doc(widget.p.pid)
          .set({'status': 'completed'}, SetOptions(merge: true)).then((value) {
        ToastWidget.showToast("Status updated Successfully");
        setState(() {
          widget.p.status = 'completed';
        });
      });
    }

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
                            child: Text(widget.p.name, style: ktCaption),
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
                      subtitle: Text(widget.p.email,
                          style: ktBody2.copyWith(color: kcTextLight)),
                      trailing: SizedBox(
                        width: 20,
                        height: 20,
                        child: widget.p.status == 'loading'
                            ? FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : GestureDetector(
                                child: widget.p.status == 'pending'
                                    ? Icon(Icons.pending_actions_rounded)
                                    : Icon(
                                        Icons.assignment_turned_in_outlined,
                                        color: Colors.green,
                                      ),
                                onTap: () {
                                  if (widget.p.status == 'pending') {
                                    accepttask();
                                  }
                                },
                              ),
                      ),
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
