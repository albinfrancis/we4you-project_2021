import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:we4you/screen/dash_board/dash_board.dart';
import 'package:we4you/screen/login_screen.dart';

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
    double defaultScreenWidth = MediaQuery.of(context).size.width;
    double defaultScreenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(context);
    print(defaultScreenWidth);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 85.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xFFE65100),
                      border: Border.all(
                          width: 1.0, color: const Color(0xFFE65100)),
                    ),
                    child: Center(
                      child: isSignin
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ))
                          : Text(
                              'LOGIN',
                              style: TextStyle(
                                fontFamily: 'Cormorant Garamond',
                                fontSize: 14,
                                color: const Color(0xffffffff),
                                letterSpacing: 0.84,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(DashBoard.routeName);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xFFE65100),
                      border: Border.all(
                          width: 1.0, color: const Color(0xFFE65100)),
                    ),
                    child: Center(
                      child: isSignin
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ))
                          : Text(
                              'REGISTER',
                              style: TextStyle(
                                fontFamily: 'Cormorant Garamond',
                                fontSize: 14,
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
          ),
        ),
      ),
    );
  }
}
