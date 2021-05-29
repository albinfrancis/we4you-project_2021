import 'package:flutter/material.dart';
import 'package:we4you/screen/doctor/settings.dart';
import 'package:we4you/screen/pharmacy/orders.dart';

class PharmacyDashboard extends StatefulWidget {
  PharmacyDashboard({Key key}) : super(key: key);
  static final routeName = './PharmacyDashboard';

  @override
  _PharmacyDashboardState createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFE65100), title: Text("We4you")),
      body: new Container(
        child: new Image.asset(
          'assets/we.png',
          height: 120,
          width: 120,
        ),
        alignment: Alignment.center,
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
              child: new UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.orange.shade900),
                accountName: new Text('Pharmacy'),
                accountEmail: new Text('pharmacy@gmail.com'),
                currentAccountPicture: Icon(
                  Icons.account_circle_outlined,
                  size: 50,
                ),
              ),
            ),
            new ListTile(
              leading: Icon(
                Icons.book_online,
                size: 35,
              ),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Orders()));
              },
            ),
            new ListTile(
              leading: Icon(
                Icons.settings,
                size: 35,
              ),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Settings()));
              },
            ),
            new ListTile(
              leading: Icon(
                Icons.logout,
                size: 35,
              ),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
