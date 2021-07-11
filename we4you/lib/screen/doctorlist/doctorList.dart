import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:we4you/modelz/doctors.dart';
import 'package:we4you/screen/doctorlist/bookingList.dart';
import 'package:we4you/screen/doctorlist/widget/doctorWidget.dart';
import 'package:we4you/screen/patientlist/patientlist.dart';

import 'package:we4you/utils/colors.dart';

class DoctorList extends StatefulWidget {
  static final routeName = './doctorList';

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<DoctorList> {
  List<DoctorModel> doctors = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Doctors',
                    style: TextStyle(
                        color: kcText,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(BookingList.routeName);
                      },
                      icon: Icon(
                        Icons.list_alt_outlined,
                        color: kcText,
                      ))
                ],
              )),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  doctors = [];
                  snapshot.data.docs.forEach((element) {
                    if (element['user_type'] == "doctor") {
                      DoctorModel doctorsmodel =
                          DoctorModel.fromMap(element.data(), element.id);
                      doctors.add(doctorsmodel);
                    }
                  });

                  return Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          itemCount: doctors.length,
                          itemBuilder: (buildContext, index) =>
                              DoctorWidget(doc: doctors[index])));
                } else {
                  return Center(
                    child: Loading(
                      indicator: BallPulseIndicator(),
                      size: 40.0,
                      color: kcText,
                    ),
                  );
                }
              })
        ]),
      ),
    );
  }
}
