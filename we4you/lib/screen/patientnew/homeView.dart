import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/screen/patientnew/CRUDModel.dart';
import 'package:we4you/screen/patientnew/ItemWidget.dart';
import 'package:we4you/screen/patientnew/MedicineModel.dart';
import 'package:we4you/screen/patientnew/checkout.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/toast_widget.dart';

class HomeView extends StatefulWidget {
  static final routeName = './homee';
  String str;
  HomeView({Key key, this.str}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final db = FirebaseFirestore.instance;

  String str = "";
  CollectionReference chatReference;

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    str = widget.str;
    chatReference = db.collection("data");
  }

  bool containsMedicine(String medicinename) {
    List<String> list = str.split("\n");

    for (var i = 0; i < list.length; i++) {
      if (list[i].toLowerCase().contains(medicinename.toLowerCase())) {
        return true;
      }
    }

    return false;
  }

  addProductQty(int index) {
    print(index);

    products[index].qty = products[index].qty + 1;
  }

  removeProductQty(int index) {
    print(index);
    products[index].qty > 0
        ? products[index].qty = products[index].qty - 1
        : products[index].qty = 0;

    print(products[index].qty);
  }

  checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var username = prefs.getString('username');

    double totalbill = 0.0;

    print(products);

    List yourItemList = [];
    for (int i = 0; i < products.length; i++) {
      if (products[i].qty > 0) {
        yourItemList.add({
          "productId": products[i].id,
          "name": products[i].name,
          "price": products[i].price,
          "quantity": products[i].qty
        });
        totalbill =
            totalbill + (products[i].qty * double.parse(products[i].price));
      }
    }

    if (yourItemList.length != 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckoutScreen(
              yourItemList, totalbill.toString(), email, username)));
    } else {
      ToastWidget.showToast('No Products Found ');
    }
  }

  // submitdata() async {
  // double totalbill = 0.0;

  // List yourItemList = [];
  // for (int i = 0; i < products.length; i++) {
  //   if (products[i].qty > 0) {
  //     yourItemList.add({
  //       "productId": products[i].id,
  //       "name": products[i].name,
  //       "price": products[i].price,
  //       "quantity": products[i].qty
  //     });
  //     totalbill =
  //         totalbill + (products[i].qty * double.parse(products[i].price));
  //   }
  // }

  // if (products.length != 0) {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var email = prefs.getString('email');
  //     var username = prefs.getString('username');
  //     var token = prefs.getString('token');
  //     var now = new DateTime.now();
  //     var formatter = new DateFormat('yyyy-MM-dd');
  //     String formattedDate = formatter.format(now);

  //     db.collection('orders').doc().set({
  //       'Customer': username,
  //       "email": email,
  //       "token": token,
  //       "date": formattedDate,
  //       "totalbill": totalbill.toString(),
  //       "status": 'Placed',
  //       "Item": FieldValue.arrayUnion(yourItemList),
  //     });

  //     ToastWidget.showToast('Product Purchased Successfully');
  // } else {
  //   ToastWidget.showToast('No Products Found ');
  // }
  // }

  // showAlertDialog(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   var username = prefs.getString('username') ?? '';
  //   Widget cancelButton = TextButton(
  //     child: Text("Cancel"),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );
  //   Widget continueButton = TextButton(
  //     child: Text("Confirm"),
  //     onPressed: () {
  //       submitdata();
  //       Navigator.of(context).pop();
  //     },
  //   );

  //   AlertDialog alert = AlertDialog(
  //     title: Text("Hi, $username"),
  //     content: Text("Would you like to confirm purchase ?"),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 50,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: RichText(
              text: TextSpan(
                  text: 'We4You,',
                  style: TextStyle(
                      color: kcText, fontSize: 21, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\nWe help you live happy with smart choices,',
                      style: TextStyle(
                          color: kcTextLight,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    )
                  ]),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 95),
          child: StreamBuilder(
              stream: productProvider.fetchProductsAsStream(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  products = [];
                  snapshot.data.docs.forEach((element) {
                    if (containsMedicine(element.get('medicinename'))) {
                      Product product =
                          Product.fromMap(element.data(), element.id, 1);
                      products.add(product);
                    }
                  });

                  return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.50),
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0),
                      itemCount: products.length,
                      itemBuilder: (buildContext, index) => ItemWidget(
                          productName: products[index].name,
                          price: products[index].price,
                          bytes: Base64Decoder().convert(products[index].img),
                          onPressedAdd: () {
                            addProductQty(index);
                          },
                          onPressedRemove: () {
                            removeProductQty(index);
                          }));
                } else {
                  return Center(
                    child: Loading(
                      indicator: BallPulseIndicator(),
                      size: 40.0,
                      color: kcText,
                    ),
                  );
                }
              }),
        ),
        Positioned(
          bottom: 40,
          left: 30,
          right: 30,
          child: SizedBox(
              width: 150,
              height: 45,
              child: TextButton(
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE65100),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  checkData();
                },
              )),
        ),
      ]),
    );
  }
}
