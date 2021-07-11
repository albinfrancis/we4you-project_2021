import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
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
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: new Text('Settings'),
      ),
      body: new Card(
        child: InkWell(
          onTap: () {
            removeuserInfo();
          },
          child: Center(
            child: Container(
              height: 180,
              width: 190,
              decoration: BoxDecoration(color: const Color(0xFFE0E0E0)),
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
      ),
    );
  }
}
