import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we4you/screen/admin/admin_dashboard.dart';
import 'package:we4you/screen/patient/patient_dashboard.dart';
import 'package:we4you/screen/doctor/doctor_dashboard.dart';
import 'package:we4you/screen/pharmacy/pharmacy_dashboard.dart';
import 'package:we4you/screen/admin/admin_register.dart';
import 'package:we4you/screen/dash_board/dash_board.dart';
import 'package:we4you/screen/doctor/doctor_register.dart';
import 'package:we4you/screen/login_screen.dart';
import 'package:we4you/screen/patient/patient_register.dart';
import 'package:we4you/screen/pharmacy/pharmacy_register.dart';
import 'package:we4you/screen/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String title;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dibor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        DashBoard.routeName: (context) => DashBoard(),
        AdminRegister.routeName: (context) => AdminRegister(),
        AdminDashboard.routeName: (context) => AdminDashboard(),
        PatientDashboard.routeName: (context) => PatientDashboard(),
        DoctorDashboard.routeName: (context) => DoctorDashboard(),
        PharmacyDashboard.routeName: (context) => PharmacyDashboard(),
        LoginScreen.routeName: (context) => LoginScreen(),
        DoctorRegister.routeName: (context) => DoctorRegister(),
        PatientRegister.routeName: (context) => PatientRegister(),
        PharmacyRegister.routeName: (context) => PharmacyRegister()
      },
    );
  }
}
