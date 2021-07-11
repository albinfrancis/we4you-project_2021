import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/screen/doctor/profile.dart';
import 'package:we4you/screen/patientlist/patientlist.dart';
import 'package:we4you/screen/pharmacy/profile.dart';

class DoctorDashboard extends StatefulWidget {
  DoctorDashboard({Key key}) : super(key: key);
  static final routeName = './DoctorDashboard';

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    PatientList(),
    DoctorProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          /* BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),*/
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),

      // body: Center(
      //   child: SingleChildScrollView(
      //     child: ConstrainedBox(
      //       constraints: BoxConstraints(),
      //       child: Column(
      //         children: <Widget>[
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               new Card(
      //                 child: InkWell(
      //                   onTap: () {
      //                     Navigator.push(
      //                         context,
      //                         new MaterialPageRoute(
      //                             builder: (BuildContext context) =>
      //                                 new Profile()));
      //                   },
      //                   child: new Container(
      //                     height: 180,
      //                     width: 190,
      //                     decoration:
      //                         BoxDecoration(color: const Color(0xFFE0E0E0)),
      //                     padding: new EdgeInsets.all(20.0),
      //                     child: Center(
      //                       child: new Column(
      //                         children: <Widget>[
      //                           Icon(
      //                             Icons.account_circle_outlined,
      //                             size: 80,
      //                             color: Colors.orange.shade900,
      //                           ),
      //                           new Text(
      //                             'Profile',
      //                             style: TextStyle(
      //                               fontSize: 21,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.orange.shade900,
      //                             ),
      //                             textAlign: TextAlign.center,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               new Card(
      //                 child: InkWell(
      //                   onTap: () {
      //   Navigator.of(context)
      //       .pushReplacementNamed(PatientList.routeName);
      // },
      //                   child: new Container(
      //                     height: 180,
      //                     width: 190,
      //                     decoration:
      //                         BoxDecoration(color: const Color(0xFFE0E0E0)),
      //                     padding: new EdgeInsets.all(20.0),
      //                     child: Center(
      //                       child: new Column(
      //                         children: <Widget>[
      //                           Icon(
      //                             Icons.book_online,
      //                             size: 80,
      //                             color: Colors.orange.shade900,
      //                           ),
      //                           new Text(
      //                             'Appointments',
      //                             style: TextStyle(
      //                                 fontSize: 21,
      //                                 fontWeight: FontWeight.bold,
      //                                 color: Colors.orange.shade900),
      //                             textAlign: TextAlign.center,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               new Card(
      //                 child: InkWell(
      //                   onTap: () {
      //                     Navigator.push(
      //                         context,
      //                         new MaterialPageRoute(
      //                             builder: (BuildContext context) =>
      //                                 new Settings()));
      //                   },
      //                   child: new Container(
      //                     height: 180,
      //                     width: 190,
      //                     decoration:
      //                         BoxDecoration(color: const Color(0xFFE0E0E0)),
      //                     padding: new EdgeInsets.all(20.0),
      //                     child: Center(
      //                       child: new Column(
      //                         children: <Widget>[
      //                           Icon(
      //                             Icons.settings,
      //                             size: 80,
      //                             color: Colors.orange.shade900,
      //                           ),
      //                           new Text(
      //                             'Settings',
      //                             style: TextStyle(
      //                                 fontSize: 21,
      //                                 fontWeight: FontWeight.bold,
      //                                 color: Colors.orange.shade900),
      //                             textAlign: TextAlign.center,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      // new Card(
      //   child: InkWell(
      //     onTap: () {
      //       removeuserInfo();
      //     },
      //     child: new Container(
      //       height: 180,
      //       width: 190,
      //       decoration:
      //           BoxDecoration(color: const Color(0xFFE0E0E0)),
      //       padding: new EdgeInsets.all(20.0),
      //       child: Center(
      //         child: new Column(
      //           children: <Widget>[
      //             Icon(
      //               Icons.login_outlined,
      //               size: 80,
      //               color: Colors.orange.shade900,
      //             ),
      //             new Text(
      //               'Logout',
      //               style: TextStyle(
      //                   fontSize: 21,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.orange.shade900),
      //               textAlign: TextAlign.center,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
