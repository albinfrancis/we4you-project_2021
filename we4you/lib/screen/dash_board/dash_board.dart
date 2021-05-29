import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we4you/screen/admin/admin_register.dart';
import 'package:we4you/screen/doctor/doctor_register.dart';
import 'package:we4you/screen/patient/patient_register.dart';
import 'package:we4you/screen/pharmacy/pharmacy_register.dart';
import 'package:we4you/services/curd.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);
  static final routeName = './DashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  CurdMethods curdObj = new CurdMethods();

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = MediaQuery.of(context).size.width;
    double defaultScreenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(context);
    print(defaultScreenWidth);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AdminRegister.routeName);
            },
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(100.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xFFE65100),
                border: Border.all(width: 1.0, color: const Color(0xFFE65100)),
              ),
              child: Center(
                child: Text(
                  'Admin',
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: ScreenUtil().setSp(25),
                    color: const Color(0xffffffff),
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          //doctor
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(DoctorRegister.routeName);
            },
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(100.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xFFE65100),
                border: Border.all(width: 1.0, color: const Color(0xFFE65100)),
              ),
              child: Center(
                child: Text(
                  'Doctor',
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: ScreenUtil().setSp(25),
                    color: const Color(0xffffffff),
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          //patient
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PharmacyRegister.routeName);
            },
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(100.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xFFE65100),
                border: Border.all(width: 1.0, color: const Color(0xFFE65100)),
              ),
              child: Center(
                child: Text(
                  'Pharmacy',
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: ScreenUtil().setSp(25),
                    color: const Color(0xffffffff),
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),

          //pharmacy
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PatientRegister.routeName);
            },
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(100.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xFFE65100),
                border: Border.all(width: 1.0, color: const Color(0xFFE65100)),
              ),
              child: Center(
                child: Text(
                  'Patient',
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: ScreenUtil().setSp(25),
                    color: const Color(0xffffffff),
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
