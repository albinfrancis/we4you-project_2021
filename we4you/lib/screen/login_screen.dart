import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:we4you/utils/toast_widget.dart';

import 'admin/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  static final routeName = './LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignin = false;
  bool skipLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formlogin = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  Widget _loadingBtn() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color(0xFFE65100),
        border: Border.all(width: 1.0, color: const Color(0xFFE65100)),
      ),
      child: Center(
        child: Loading(
          indicator: BallPulseIndicator(),
          size: 40.0,
          color: Colors.white,
        ),
      ),
    );
  }

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
      body: Form(
        key: formlogin,
        child: Container(
            child: Container(
                child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  // obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                isSignin
                    ? _loadingBtn()
                    : InkWell(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formlogin.currentState.validate()) {
                            setState(() {
                              isSignin = true;
                            });

                            await auth
                                .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((v) async {
                              print("success");
                              print(
                                  "----------------------------------------------------------------123456789");
                              print(v);

                              Navigator.of(context)
                                  .pushNamed(AdminDashboard.routeName);
                            }).catchError((e) {
                              print("catch");
                              print(e);
                              print(e.code);
                              setState(() {
                                isSignin = false;
                              });
                              if (e.code == 'user-not-found') {
                                ToastWidget.showToast("Not a registered user");
                              } else if (e.code == 'wrong-password') {
                                ToastWidget.showToast("Password is incorrect");
                              } else {
                                ToastWidget.showToast(e.message.toString());
                              }
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 48.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xFFE65100),
                            border: Border.all(
                                width: 1.0, color: const Color(0xFFE65100)),
                          ),
                          child: Center(
                            child: Text(
                              'SIGN UP',
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
        ))),
      ),
    );
  }
}
