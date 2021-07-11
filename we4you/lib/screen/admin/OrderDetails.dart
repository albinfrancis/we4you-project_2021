import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/modelz/orderz.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/toast_widget.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails(this.orderz, this.usertype);

  final OrderModel orderz;
  final String usertype;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  accepttask() async {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderz.oid)
        .set({'status': 'Accepted'}, SetOptions(merge: true)).then((value) {
      ToastWidget.showToast("Order Accepted");
    });
  }

  Future<http.Response> postRequest(
      String title, String message, String token) async {
    var url = 'https://fcm.googleapis.com/fcm/send';
    var header = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAh3OWKKk:APA91bH-LJS2JIqbZATUzi662a1Kqp0Rknwj5K2GpTlPlfPxvWaK7Mm6jb5FnuwLH0ykapHq-m92KOeJSff8fhBXrQv_j85aobeNzzN-lI-nuZ99vzuPnEx16O9LCsbxjgGc9Txv8dWR",
    };
    var request = {
      'notification': {'title': title, 'body': message},
      'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'type': 'COMMENT'},
      'to': token
    };

    //encode Map to JSON
    var body = json.encode(request);

    var response = await http.post(url, headers: header, body: body);

    return response;
  }

  Padding acceptwidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: TextButton(
        onPressed: () async {
          accepttask();
          postRequest('Order Accepted', 'Order Id : ${widget.orderz.oid}',
              widget.orderz.token);
        },
        child: Text('Accept'),
        style: ElevatedButton.styleFrom(
          primary: Color(0XFFEE65100),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
  }

  ListView itemlist(List<dynamic> pdata) {
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

  orderType() {
    return Padding(
        padding: const EdgeInsets.only(
            top: 25.0, left: 10.0, right: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Order ID: ${widget.orderz.oid}",
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, color: Colors.red),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "${widget.orderz.date} ",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 12, color: kcText),
            ),
          ],
        ));
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
              "${widget.orderz.customer}",
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, color: Colors.red),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "${widget.orderz.email} ",
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
            'Order Details',
            style: TextStyle(
                color: kcText, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          orderType(),
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
              itemlist(widget.orderz.itemlist),
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
                    widget.orderz.totalbill,
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
          if (widget.usertype == 'pharmacy')
            widget.orderz.status == 'Placed'
                ? acceptwidget()
                : SizedBox(
                    width: 0,
                  ),
        ]),
      ),
    );
  }
}
