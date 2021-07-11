import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:we4you/screen/dash_board/dash_board.dart';
import 'package:we4you/screen/login_screen.dart';
import 'package:we4you/utils/styles.dart';

class LoginDashboard extends StatefulWidget {
  LoginDashboard({Key key}) : super(key: key);
  static final routeName = './LoginDashboard';

  @override
  _LoginDashboardState createState() => _LoginDashboardState();
}

class _LoginDashboardState extends State<LoginDashboard> {
  bool isSignin = false;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NeumorphicButton(
                onPressed: () {
                  NeumorphicTheme.of(context).themeMode =
                      NeumorphicTheme.isUsingDark(context)
                          ? ThemeMode.light
                          : ThemeMode.dark;
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                padding: new EdgeInsets.only(
                    top: 10, left: 20, bottom: 50, right: 20),
                child: Image.asset('assets/we.png',
                    fit: BoxFit.fill, width: 200, height: 200),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Get Started",
                style: ktHeading6,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                child: Text(
                  "Sometimes things aren't clear right away. That's where you need to be patient and persevere and see where things lead.",
                  textAlign: TextAlign.center,
                  style: ktBody1,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.19,
              ),
              Container(
                width: 300,
                child: NeumorphicButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                        color: Colors.orange.shade900
                        //border: NeumorphicBorder()
                        ),
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: ktButton,
                    )),
              ),
              SizedBox(height: 25),

              Container(
                width: 300,
                child: NeumorphicButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(DashBoard.routeName);
                  },
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                      color: Colors.orange.shade900),
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "REGISTER",
                    textAlign: TextAlign.center,
                    style: ktButton,
                  ),
                ),
              ),

              // InkWell(
              //   onTap: () {
              //     Navigator.of(context).pushNamed(DashBoard.routeName);
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     height: 48,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5.0),
              //       color: const Color(0xFFE65100),
              //       border:
              //           Border.all(width: 1.0, color: const Color(0xFFE65100)),
              //     ),
              //     child: Center(
              //       child: isSignin
              //           ? Center(
              //               child: CircularProgressIndicator(
              //               backgroundColor: Colors.white,
              //             ))
              //           : Text(
              //               'REGISTER',
              //               style: TextStyle(
              //                 fontFamily: 'Cormorant Garamond',
              //                 fontSize: 14,
              //                 color: const Color(0xffffffff),
              //                 letterSpacing: 0.84,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //               textAlign: TextAlign.left,
              //             ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
