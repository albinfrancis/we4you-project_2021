import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/toast_widget.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen(this.yourItemList, this.total, this.email, this.username);

  List yourItemList = [];
  String total = '0';
  String email;
  String username;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String formattedDate = "";

  String paymentmode = '0';

  void _handlePaymentChange(String value) {
    setState(() {
      paymentmode = value;
    });
  }

  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);
  }

  submitdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var username = prefs.getString('username');

    var token = prefs.getString('token');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatttedDate = formatter.format(now);
    final db = FirebaseFirestore.instance;

    db.collection('orders').doc().set({
      'Customer': username,
      "email": email,
      "token": token,
      "date": formatttedDate,
      "totalbill": widget.total.toString(),
      "status": 'Placed',
      "Item": FieldValue.arrayUnion(widget.yourItemList),
    });
  }

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
        ToastWidget.showToast("Order Placed Successfully");
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Hi, $username"),
      content: Text("Would you like to confirm purchase ?"),
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

  Padding acceptwidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: TextButton(
        onPressed: () async {
          showAlertDialog(context);
        },
        child: Text('Purchase Now'),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFE65100),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
  }

  ListView itemlist(List pdata) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => Divider(
        thickness: 1,
      ),
      shrinkWrap: true,
      itemCount: pdata.length,
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> _map = pdata[index];

        double amt = _map['quantity'] * double.parse(_map['price']);

        return ListTile(
          contentPadding: EdgeInsets.only(left: 2, right: 2),
          title: Text(_map['name']),
          subtitle: Text("Qty ${_map['quantity']}"),
          trailing: Text(
            "$amt",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }

  customerType() {
    return Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Customer Details",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, color: kcText),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget.username}",
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, color: Colors.red),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "${widget.email}",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 12, color: kcText),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "$formattedDate ",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 12, color: kcText),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(shrinkWrap: true, children: [
          Text(
            ' : Order Summary',
            style: TextStyle(
                color: kcText, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          customerType(),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: kcText),
              borderRadius: BorderRadius.circular(4),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Item Details",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              itemlist(widget.yourItemList),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.total,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 25),
                  )
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffCACFE2)),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white),
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
        ]),
      ),
    );
  }
}
