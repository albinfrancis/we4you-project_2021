import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:we4you/screen/login_screen.dart';
import 'package:we4you/services/curd.dart';
import 'package:we4you/utils/colors.dart';
import 'package:we4you/utils/toast_widget.dart';
import 'dart:convert';

class AdminRegister extends StatefulWidget {
  AdminRegister({Key key}) : super(key: key);
  static final routeName = './sing_up';

  @override
  _AdminRegisterState createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  bool checkBoxValue = false;
  bool _value = false;
  bool isSignup = false;
  bool skipLoading = false;
  final _firstnameController = TextEditingController();
  final adminController = TextEditingController();
  final auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController1 = TextEditingController();
  String _title, _dob = '', _checkPHNO;

  final _lastnameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  int _groupValue = -1;
  final format = DateFormat("dd-MM-yyyy");
  CurdMethods curdObj = new CurdMethods();

  String pswValidation(String value) {
    // Pattern pattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    Pattern pattern =
        r"^(?=.*\d)(?=.*[a-z])(?=.*?[!@#\$&*~,:;=?#|'<>.^*%!-])(?=.*[a-zA-Z]).{8,}$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'include Special Characters,Digits,letters and equal or greater than 8 symbols';
    else
      return null;
  }

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

  radiobutton() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Text('Gender', style: TextStyle(fontSize: 18)),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RadioListTile(
                        value: 0,
                        groupValue: _groupValue,
                        title: Text("Male"),
                        onChanged: (newValue) =>
                            setState(() => _groupValue = newValue),
                        activeColor: Colors.red,
                        selected: false,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RadioListTile(
                        value: 1,
                        groupValue: _groupValue,
                        title: Text("Female"),
                        onChanged: (newValue) =>
                            setState(() => _groupValue = newValue),
                        activeColor: Colors.red,
                        selected: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDOBcontainer() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(10.0)),
          Container(
            alignment: Alignment.topCenter,
            color: HexColor('#F29509'),
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: DateTimeField(
                format: format,
                onSaved: (value) => _dob = format.format(value).toString(),
                validator: (value) {
                  if (value == null) {
                    return 'Please choose date of birth';
                  }
                  return null;
                },
                style: TextStyle(fontSize: 15),
                resetIcon: Icon(Icons.calendar_today),
                decoration: InputDecoration(
                    hintText: 'Select Date',
                    hintStyle: TextStyle(
                      color: HexColor('#1C2344'),
                      fontFamily: 'Poppins-ExtraLight',
                      fontSize: 12,
                    ),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: HexColor('#00BC87'),
                    )),
                onShowPicker: (context, currentValue) async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1800),
                    lastDate: DateTime.now(),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: HexColor('#00BC87'),
                          accentColor: HexColor('#00BC87'),
                          primaryTextTheme: TextTheme(
                              // display1: TextStyle(
                              //   fontFamily: 'Poppins-Regular',
                              // ),
                              // subhead: TextStyle(
                              //   fontFamily: 'Poppins-Regular',
                              // ),
                              ),
                          colorScheme:
                              ColorScheme.light(primary: HexColor('#00BC87')),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child,
                      );
                    },
                  );

                  if (date != null) {
                    _dob = DateTimeField.combine(date, null).toString();

                    return DateTimeField.combine(date, null);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0, bottom: 38),
                      child: Text(
                        'create account',
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xFFE65100),
                          letterSpacing: 1.036,
                          fontWeight: FontWeight.w600,
                          height: 1.0714285714285714,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      // obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: adminController,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please enter Admin id';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Admin id',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      // obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: _firstnameController,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please enter  Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    radiobutton(),
                    SizedBox(
                      height: 15,
                    ),
                    // _buildDOBcontainer(),
                    SizedBox(
                      height: 15,
                    ),
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
                    isSignup
                        ? _loadingBtn()
                        : InkWell(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              print(_groupValue);
                              if (_formkey.currentState.validate()) {
                                isSignup = true;
                                await auth
                                    .createUserWithEmailAndPassword(
                                  email: _emailController.text.toString(),
                                  password: _passwordController.text.toString(),
                                )
                                    .then((v) async {
                                  print("yo");
                                  print(v.user.uid);
                                  // print(place);
                                  var userId = v.user.uid;
                                  var data = {
                                    "createdAt": DateTime.now(),
                                    "email": v.user.email.toString(),
                                    "user_type": "admin",
                                    "gender":
                                        _groupValue == 0 ? "Male" : "Female",
                                    "name":
                                        _firstnameController.text.toString(),
                                    "id": userId,
                                    "admin_id":
                                        adminController.text.toString() +
                                            "" +
                                            userId,
                                  };
                                  var result =
                                      curdObj.addUser("users", userId, data);
                                  result.then((v) {
                                    Navigator.of(context)
                                        .pushNamed(LoginScreen.routeName);

                                    setState(() {
                                      // isLoading = false;
                                    });
                                  }).catchError((e) {
                                    print(e.message.toString());
                                    setState(() {
                                      // isLoading = false;
                                    });
                                    ToastWidget.showToast(e.message.toString());
                                  });
                                }).catchError((e) {
                                  setState(() {
                                    // isLoading = false;
                                  });
                                  ToastWidget.showToast(e.message.toString());
                                });
                              } else {
                                setState(() {
                                  // validation = true;
                                });
                              }
                              setState(() {});
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
                  ]),
            )),
      ),
    );
  }
}
