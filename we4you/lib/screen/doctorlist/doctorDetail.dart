import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/modelz/doctors.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/styles.dart';
import 'package:we4you/utils/toast_widget.dart';

class DoctorDetailScreen extends StatefulWidget {
  final DoctorModel doctor;

  DoctorDetailScreen({Key key, this.doctor}) : super(key: key);

  @override
  _DoctorDetailScreenState createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  String formattedDate = "";

  String paymentmode = '0';

  DateTime bookingdate;

  final db = FirebaseFirestore.instance;

  void _handlePaymentChange(String value) {
    setState(() {
      paymentmode = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  var format = new DateFormat('dd-MM-yyyy');
  showAlertDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username') ?? '';
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        submitdata();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Hi, $username"),
      content: Text("Would you like to confirm booking ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  submitdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var username = prefs.getString('username');
    var userid = prefs.getString('userid');

    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formatttedDate = formatter.format(now);

    db.collection('bookingTable').doc().set({
      'user': username,
      "email": email,
      "userid": userid,
      "placedDate": formatttedDate,
      "bookingdate": formatter.format(bookingdate),
      "status": 'pending',
      'doctor': widget.doctor.name,
      'doctorId': widget.doctor.doctorid,
    });

    ToastWidget.showToast("Booked Successfully");
    Navigator.of(context).pop();
  }

  Future<bool> doesNameAlreadyExist(String id, String date) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('bookingTable')
        .where('userid', isEqualTo: id)
        .where('bookingdate', isEqualTo: date)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length >= 1;
  }

  Future<bool> doesLimitOver(String date) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('bookingTable')
        .where('bookingdate', isEqualTo: date)
        .limit(5)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length >= 5;
  }

  Padding acceptwidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Container(
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            var now = new DateTime.now();

            if (bookingdate.isAfter(now)) {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              var userid = prefs.getString('userid');

              var formatter = new DateFormat('dd-MM-yyyy');
              String formatttedDate = formatter.format(bookingdate);

              bool isLimitexists = false;
              isLimitexists = await doesLimitOver(formatttedDate);
              if (isLimitexists) {
                ToastWidget.showToast("Booking Limit Over. Try another day");
              } else {
                bool isexists = false;
                isexists = await doesNameAlreadyExist(userid, formatttedDate);

                if (isexists) {
                  ToastWidget.showToast("Already Booked");
                } else {
                  showAlertDialog(context);
                }
              }
            } else {
              ToastWidget.showToast("please select valid date to continue..");
            }
          },
          child: Text('Book Now'),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange.shade900,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kcAppBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Department',
                      style: ktBody2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.doctor.department,
                      style: ktCaption,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Doctor Name',
                      style: ktBody2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.doctor.name,
                      style: ktCaption,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Available Days',
                      style: ktCaption,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 22,
                      width: 118,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: kcLightTurquoice,
                      ),
                      padding: const EdgeInsets.only(right: 8, left: 10),
                      child: Center(
                        child: Text(
                          widget.doctor.dateAvailable,
                          style: TextStyle(
                              color: kcTurquoice,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Time Available',
                      style: ktCaption,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 22,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: kcLightOrange,
                      ),
                      padding: const EdgeInsets.only(right: 8, left: 10),
                      child: Center(
                        child: Text(
                          widget.doctor.timeAvailable,
                          style: TextStyle(
                              color: kcOrange,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Pick Date',
                      style: ktBody2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: kcTextLight.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: DateTimeField(
                        format: format,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
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
                      height: 20,
                    ),
                    Text(
                      'Payment Mode',
                      style: ktBody2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            color: kcTextLight.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Radio<String>(
                            value: "0",
                            groupValue: paymentmode,
                            onChanged: _handlePaymentChange,
                          ),
                          Text("COD"),
                          Radio<String>(
                            value: "1",
                            groupValue: paymentmode,
                            onChanged: _handlePaymentChange,
                          ),
                          Text("Online"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    acceptwidget()
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
