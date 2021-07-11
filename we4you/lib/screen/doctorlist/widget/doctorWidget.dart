import 'package:flutter/material.dart';
import 'package:we4you/modelz/doctors.dart';
import 'package:we4you/screen/doctorlist/doctorDetail.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/styles.dart';

class DoctorWidget extends StatelessWidget {
  final DoctorModel doc;

  const DoctorWidget({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DoctorDetailScreen(
                    doctor: doc,
                  )));
        },
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(108, 116, 138, 1).withOpacity(0.15),
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(doc.name, style: ktCaption),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                    ],
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doc.department,
                            style: ktBody2.copyWith(color: kcTextLight)),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: kcLightTurquoice,
                              ),
                              padding:
                                  const EdgeInsets.only(right: 8, left: 10),
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Center(
                                child: Text(
                                  doc.dateAvailable,
                                  style: TextStyle(
                                      color: kcTurquoice,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              height: 26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: kcLightOrange,
                              ),
                              padding:
                                  const EdgeInsets.only(right: 8, left: 10),
                              child: Center(
                                child: Text(
                                  doc.timeAvailable,
                                  style: TextStyle(
                                      color: kcOrange,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                  trailing: CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0xFFE9EFF6),
                    child: Image.asset(
                      'assets/ic_nextarrow.png',
                      color: kcTurquoice,
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
