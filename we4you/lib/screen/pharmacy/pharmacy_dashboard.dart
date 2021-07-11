import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/modelz/orderz.dart';
import 'package:we4you/screen/admin/OrdersWidget.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/fcm.dart';

class PharmacyDashboard extends StatefulWidget {
  PharmacyDashboard({Key key}) : super(key: key);
  static final routeName = './PharmacyDashboard';

  @override
  _PharmacyDashboardState createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  List<OrderModel> orders = [];

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirm"),
      onPressed: () {
        removeuserInfo();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Alert !!!"),
      content: Text("Are you sure want to logout ?"),
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

  removeuserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('username');
    prefs.remove('token');
    prefs.remove('usertype');
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
                    'DashBoard',
                    style: TextStyle(
                        color: kcText,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('orders').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  orders = [];
                  snapshot.data.docs.forEach((element) {
                    OrderModel product =
                        OrderModel.fromMap(element.data(), element.id);
                    orders.add(product);
                  });

                  return Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          itemCount: orders.length,
                          itemBuilder: (buildContext, index) =>
                              OrdersWidget(orderList: orders[index])));
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
