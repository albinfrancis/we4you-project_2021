import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we4you/screen/patient/patient_dashboard.dart';
import 'package:we4you/screen/pharmacy/pharmacy_dashboard.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/styles.dart';
import 'package:we4you/utils/toast_widget.dart';

import 'admin/admin_dashboard.dart';
import 'doctor/doctor_dashboard.dart';

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
    return NeumorphicButton(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Loading(
          indicator: BallPulseIndicator(),
          size: 40.0,
          color: kcText,
        ),
      ),
    );
  }

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  saveuserinfo(Map<String, dynamic> documentData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', documentData['email']);
    prefs.setString('username', documentData['name']);
    prefs.setString('token', documentData['token']);
    prefs.setString('usertype', documentData['user_type']);
    prefs.setString('userid', documentData['id']);

    if (documentData['user_type'] == 'admin') {
      Navigator.of(context).pushReplacementNamed(AdminDashboard.routeName);
    } else if (documentData['user_type'] == 'doctor') {
      Navigator.of(context).pushReplacementNamed(DoctorDashboard.routeName);
    } else if (documentData['user_type'] == 'pharmacy') {
      Navigator.of(context).pushReplacementNamed(PharmacyDashboard.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(PatientDashboard.routeName);
    }
  }

  Future<bool> setFCMNotification(String uid) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    String token = await _firebaseMessaging.getToken();
    if (token != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'token': token}, SetOptions(merge: true)).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .where(FieldPath.documentId, isEqualTo: uid.trim())
            .get()
            .then((event) {
          if (event.docs.isNotEmpty) {
            Map<String, dynamic> documentData = event.docs.single.data();
            saveuserinfo(documentData);
          }
        }).catchError((e) => print("error fetching data: $e"));
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    double defaultScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: defaultScreenHeight,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: defaultScreenHeight * 0.05,
                  ),
                  NeumorphicText(
                    "Welcome!",
                    style: NeumorphicStyle(
                        depth: 4, //customize depth here
                        color: kcText),
                    textStyle: NeumorphicTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  Text("Sign in to continue", style: ktCaption),
                  SizedBox(
                    height: defaultScreenHeight * 0.2,
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formlogin,
                        child: Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            style: ktBody2,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Email"),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            obscureText: _obscureText,
                            style: ktBody2,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () => _toggle(),
                                  icon: Icon(Icons.remove_red_eye),
                                )),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          if (isSignin)
                            _loadingBtn()
                          else
                            Container(
                              width: 150,
                              height: 48,
                              child: NeumorphicButton(
                                onPressed: () async {
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
                                      setFCMNotification(v.user.uid.trim());
                                    }).catchError((e) {
                                      setState(() {
                                        isSignin = false;
                                      });
                                      if (e.code == 'user-not-found') {
                                        ToastWidget.showToast(
                                            "Not a registered user");
                                      } else if (e.code == 'wrong-password') {
                                        ToastWidget.showToast(
                                            "Password is incorrect");
                                      } else {
                                        ToastWidget.showToast(
                                            e.message.toString());
                                      }
                                    });
                                  }
                                },
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(25)),
                                    color: Colors.orange.shade900),
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    'SIGN UP',
                                    style: ktButton,
                                  ),
                                ),
                              ),
                            ),
                        ]),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     double defaultScreenWidth = MediaQuery.of(context).size.width;
//     double defaultScreenHeight = MediaQuery.of(context).size.height;
//     ScreenUtil.init(context);
//     print(defaultScreenWidth);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFE65100),
//       ),
//       body: Form(
//         key: formlogin,
//         child: Container(
//             child: Container(
//                 child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TextFormField(
//                   // obscureText: true,
//                   keyboardType: TextInputType.emailAddress,
//                   controller: _emailController,
//                   validator: (value) {
//                     if (value.trim().isEmpty) {
//                       return 'Please enter email';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   obscureText: true,
//                   keyboardType: TextInputType.emailAddress,
//                   controller: _passwordController,
//                   validator: (value) {
//                     if (value.trim().isEmpty) {
//                       return 'Please enter password';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'password',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 if (isSignin)
//                   _loadingBtn()
//                 else
//                   InkWell(
//                     onTap: () async {
//                       FocusScope.of(context).unfocus();
//                       if (formlogin.currentState.validate()) {
//                         setState(() {
//                           isSignin = true;
//                         });

//                         await auth
//                             .signInWithEmailAndPassword(
//                                 email: _emailController.text,
//                                 password: _passwordController.text)
//                             .then((v) async {
//                           print(v);

//                           Navigator.of(context)
//                               .pushNamed(PatientDashboard.routeName);
//                         }).catchError((e) {
//                           print("catch");
//                           print(e);
//                           print(e.code);
//                           setState(() {
//                             isSignin = false;
//                           });
//                           if (e.code == 'user-not-found') {
//                             ToastWidget.showToast("Not a registered user");
//                           } else if (e.code == 'wrong-password') {
//                             ToastWidget.showToast("Password is incorrect");
//                           } else {
//                             ToastWidget.showToast(e.message.toString());
//                           }
//                         });
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 48.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5.0),
//                         color: const Color(0xFFE65100),
//                         border: Border.all(
//                             width: 1.0, color: const Color(0xFFE65100)),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'SIGN UP',
//                           style: TextStyle(
//                             fontFamily: 'Cormorant Garamond',
//                             fontSize: 14,
//                             color: const Color(0xffffffff),
//                             letterSpacing: 0.84,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ))),
//       ),
//     );
//   }
// }
