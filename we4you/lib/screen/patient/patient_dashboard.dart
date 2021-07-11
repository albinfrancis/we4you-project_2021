import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/screen/doctorlist/doctorList.dart';
import 'package:we4you/screen/onlineConsultation/OnlineConsultation.dart';

import 'package:we4you/screen/patient/Ordering/ordering.dart';
import 'package:we4you/screen/patient/Ordering/widget/chatbot.dart';
import 'package:we4you/screen/patient/consultation.dart';
import 'package:we4you/screen/patient/profile.dart';
import 'package:we4you/utils/fcm.dart';

class PatientDashboard extends StatefulWidget {
  PatientDashboard({Key key}) : super(key: key);
  static final routeName = './PatientDashboard';

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  removeuserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('username');
    prefs.remove('token');
    prefs.remove('usertype');
    prefs.remove('userid');
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    super.initState();
    PushNotificationsManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: Text("we4you"),
        elevation: .1,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.login_outlined,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                removeuserInfo();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  new Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Profile()));
                      },
                      child: new Container(
                        height: 240,
                        width: 180,
                        decoration:
                            BoxDecoration(color: const Color(0xFFF5F5F5)),
                        padding: new EdgeInsets.only(
                            top: 50, left: 20, bottom: 30, right: 20),
                        child: Center(
                          child: new Column(
                            children: <Widget>[
                              Icon(
                                Icons.account_circle_outlined,
                                size: 90,
                                color: Colors.orange.shade900,
                              ),
                              new Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  new Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(DoctorList.routeName);
                      },
                      child: new Container(
                        height: 240,
                        width: 180,
                        decoration:
                            BoxDecoration(color: const Color(0xFFF5F5F5)),
                        padding: new EdgeInsets.only(
                            top: 50, left: 20, bottom: 30, right: 20),
                        child: Center(
                          child: new Column(
                            children: <Widget>[
                              Icon(
                                Icons.book_online,
                                size: 90,
                                color: Colors.orange.shade900,
                              ),
                              new Text(
                                'Booking',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade900),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  new Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Ordering()));
                      },
                      child: new Container(
                        height: 240,
                        width: 180,
                        decoration:
                            BoxDecoration(color: const Color(0xFFF5F5F5)),
                        padding: new EdgeInsets.only(
                            top: 50, left: 20, bottom: 30, right: 20),
                        child: Center(
                          child: new Column(
                            children: <Widget>[
                              Icon(
                                Icons.add_shopping_cart_outlined,
                                size: 90,
                                color: Colors.orange.shade900,
                              ),
                              new Text(
                                'Medicine Ordering',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade900),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* SizedBox(
                    height: 20,
                  ),
                  new Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        removeuserInfo();
                      },
                      child: new Container(
                        height: 200,
                        width: 180,
                        decoration:
                            BoxDecoration(color: const Color(0xFFE0E0E0)),
                        padding: new EdgeInsets.all(20.0),
                        child: Center(
                          child: new Column(
                            children: <Widget>[
                              Icon(
                                Icons.login_outlined,
                                size: 80,
                                color: Colors.orange.shade900,
                              ),
                              new Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade900),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [ */
                  new Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(OpenVideoList.routeName);
                      },
                      child: new Container(
                        height: 240,
                        width: 180,
                        decoration:
                            BoxDecoration(color: const Color(0xFFF5F5F5)),
                        padding: new EdgeInsets.only(
                            top: 50, left: 20, bottom: 30, right: 20),
                        child: Center(
                          child: new Column(
                            children: <Widget>[
                              Icon(
                                Icons.book_online,
                                size: 90,
                                color: Colors.orange.shade900,
                              ),
                              new Text(
                                'Consultation',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade900),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: IconButton(
                    icon: Icon(
                      Icons.chat_outlined,
                      size: 60,
                      color: Colors.orange.shade900,
                    ),
                    padding: new EdgeInsets.only(
                        top: 170, left: 250, bottom: 30, right: 20),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Chatbot()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
