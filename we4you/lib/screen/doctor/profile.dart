import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we4you/screen/doctor/doctor_dashboard.dart';
import 'package:we4you/utils/styles.dart';
import 'package:we4you/utils/toast_widget.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _OrdersState createState() => new _OrdersState();
}

class _OrdersState extends State<DoctorProfile> {
  String userName = "";
  String link = "";
  String docId;
  String userid;
  bool isUpdate = false;
  final _linkController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('userid');

    FirebaseFirestore.instance
        .collection('openvideo')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      setState(() {
        userName = value.docs.first['doctor'];
        link = value.docs.first['link'];
        docId = value.docs.first.id.toString();
        isUpdate = true;
      });
    });
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Padding acceptwidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: TextButton(
        onPressed: () async {
          if (_key.currentState.validate()) {
            _key.currentState.save();
            submitdata();
          }
        },
        child: Text('Update Now'),
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

  submitdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');

    if (isUpdate) {
      FirebaseFirestore.instance.collection('openvideo').doc(docId).set({
        'doctor': username,
        "link": _linkController.text.toString(),
        "id": userid,
      }, SetOptions(merge: true)).then((value) {
        ToastWidget.showToast("Updated Successfully");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DoctorDashboard()));
      });
    } else {
      db.collection('openvideo').doc().set({
        'doctor': username,
        "link": _linkController.text.toString(),
        "id": userid,
      });

      ToastWidget.showToast("Added Successfully");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DoctorDashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Link',
                  style: ktHeading5,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (link.isNotEmpty) _launchURL(link);
                  },
                  child: Text(
                    link,
                    style:
                        ktBody1.copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  // obscureText: true,
                  keyboardType: TextInputType.url,
                  controller: _linkController,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'required*';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'link',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 200,
                  child: acceptwidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
