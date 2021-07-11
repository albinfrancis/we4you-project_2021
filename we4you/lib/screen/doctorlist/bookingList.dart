import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/modelz/patient.dart';
import 'package:we4you/screen/doctorlist/widget/bookingWidget.dart';

import 'package:we4you/utils/colors.dart';

class BookingList extends StatefulWidget {
  static final routeName = './bookingList';

  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  List<PatientModel> patients = [];
  String userid;

  @override
  void initState() {
    super.initState();
    getuseridd();
  }

  void getuseridd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userid = prefs.getString('userid');
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
            child: Text(
              'Booking List',
              style: TextStyle(
                  color: kcText, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bookingTable')
                  .where('userid', isEqualTo: userid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  patients = [];
                  snapshot.data.docs.forEach((element) {
                    PatientModel patientmodel =
                        PatientModel.fromMap(element.data(), element.id);
                    patients.add(patientmodel);
                  });

                  return Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          itemCount: patients.length,
                          itemBuilder: (buildContext, index) =>
                              BookinWidget(p: patients[index])));
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
