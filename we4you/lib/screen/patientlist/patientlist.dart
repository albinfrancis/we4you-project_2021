import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/modelz/patient.dart';
import 'package:we4you/screen/patientlist/widget/patientWidget.dart';

import 'package:we4you/utils/colors.dart';

class PatientList extends StatefulWidget {
  static final routeName = './patientList';

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<PatientList> {
  List<PatientModel> patients = [];

  var formatter = new DateFormat('dd-MM-yyyy');

  var now = new DateTime.now();
  DateTime bookingdate;
  String userid;

  void getuseridd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userid = prefs.getString('userid');
  }

  @override
  void initState() {
    super.initState();
    bookingdate = now;
    getuseridd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Patients',
              style: TextStyle(
                  color: kcText, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: kcText.withOpacity(0.05),
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ],
            ),
            child: DateTimeField(
              format: formatter,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: formatter.format(bookingdate),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: kcText,
                  )),
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));

                setState(() {
                  bookingdate = date;
                });

                return date;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bookingTable')
                  .where('bookingdate',
                      isEqualTo: formatter.format(bookingdate))
                  .where('doctorId', isEqualTo: userid)
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
                              PatientWidget(p: patients[index])));
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
