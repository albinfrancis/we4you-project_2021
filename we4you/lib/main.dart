import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'package:we4you/screen/admin/admin_dashboard.dart';
import 'package:we4you/screen/doctorlist/bookingList.dart';
import 'package:we4you/screen/doctorlist/doctorList.dart';
import 'package:we4you/screen/onlineConsultation/OnlineConsultation.dart';
import 'package:we4you/screen/patient/patient_dashboard.dart';
import 'package:we4you/screen/doctor/doctor_dashboard.dart';
import 'package:we4you/screen/patientlist/patientlist.dart';
import 'package:we4you/screen/patientnew/homeView.dart';
import 'package:we4you/screen/patientnew/locator.dart';
import 'package:we4you/screen/pharmacy/pharmacy_dashboard.dart';
import 'package:we4you/screen/admin/admin_register.dart';
import 'package:we4you/screen/dash_board/dash_board.dart';
import 'package:we4you/screen/doctor/doctor_register.dart';
import 'package:we4you/screen/login_screen.dart';
import 'package:we4you/screen/patient/patient_register.dart';
import 'package:we4you/screen/pharmacy/pharmacy_register.dart';
import 'package:we4you/screen/splash_screen/splash_screen.dart';
import 'package:we4you/screen/patientnew/CRUDModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String title;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<CRUDModel>()),
      ],
      child: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'Dibor',
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          baseColor: Color(0xFFFFFFFF),
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        darkTheme: NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          depth: 6,
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
          PharmacyRegister.routeName: (context) => PharmacyRegister(),
          HomeView.routeName: (context) => HomeView(),
          DoctorList.routeName: (context) => DoctorList(),
          PatientList.routeName: (context) => PatientList(),
          BookingList.routeName: (context) => BookingList(),
          OpenVideoList.routeName: (context) => OpenVideoList(),
        },
      ),
    );
  }
}
