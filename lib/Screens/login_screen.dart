import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kelivog/Screens/account_screen.dart';
import 'package:kelivog/Screens/page_view_screen.dart';
import 'package:kelivog/Screens/register_screen.dart';
import 'package:kelivog/Screens/forgot_password_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // final success = const SnackBar(content: Text('Login succeded!'));
  // final error = const SnackBar(content: Text('Wrong email or password!'));
  // final serverError = const SnackBar(content: Text('Can\'t connect to the server!'));

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var jsonResponse;
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;

  Future<dynamic> login({String? email, String? password}) async {
    Map<String, dynamic> body = {"email": email, "password": password};

    var url = Uri.parse('https://kelivog.com/users/login');
    final postRequestResponse = await http.Client().post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    Map<String, dynamic> singingResponse = {
      'message': jsonDecode(postRequestResponse.body)['message'],
      'success': jsonDecode(postRequestResponse.body)['success'],
      'token': jsonDecode(postRequestResponse.body)['token'],
    };
    print(postRequestResponse);
    if (postRequestResponse.statusCode == 200) {
      var jsonResponse = postRequestResponse.body;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', jsonResponse);
    }
    return singingResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                header(),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("EMAIL",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 15.h),
                Card(
                  color: const Color(0xff0ced10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          color: Colors.yellow),
                      width: 0.75.sw,
                      height: 65.h,
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 10),
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        controller: loginController,
                        validator: emailValidator,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          // contentPadding:
                          // EdgeInsets.symmetric(horizontal: 10.w),
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 3.0, left: 8.0),
                        ),
                      ),
                      // child: TextFormField(
                      //   validator: emailValidator,
                      //   controller: loginController,
                      //   cursorColor: Colors.black,
                      //   decoration: const InputDecoration(
                      //     contentPadding: EdgeInsets.only(
                      //         top: 1.0, bottom: 100.0, left: 8.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(15.0)),
                      //     ),
                      //     fillColor: Colors.black,
                      //   ),
                      // ),
                      // ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("PASSWORD",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 15.h),
                Card(
                  color: const Color(0xff0ced10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          color: Colors.yellow),
                      width: 0.75.sw,
                      height: 65.h,
                      // child: Padding(
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 15, vertical: 10),
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        obscureText: true,
                        validator: passwordValidator,
                        controller: passwordController,
                        cursorColor: Colors.black,
                        showCursor: true,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          // contentPadding:
                          // EdgeInsets.symmetric(horizontal: 10.w),
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 3.0, left: 8.0),
                        ),
                      ),

                      // child: TextFormField(
                      //
                      //   decoration: const InputDecoration(
                      //     contentPadding: EdgeInsets.only(
                      //         top: 1.0, bottom: 4.0, left: 8.0),
                      //     // contentPadding:
                      //     // EdgeInsets.symmetric(horizontal: 10.w),
                      //     // border: OutlineInputBorder(
                      //     //   borderRadius: BorderRadius.all(
                      //     //       Radius.circular(15.0)),
                      //     // ),
                      //     fillColor: Colors.black,
                      //   ),
                      // ),

                      // child: TextFormField(
                      //   obscureText: true,
                      //   validator: passwordValidator,
                      //   controller: passwordController,
                      //   cursorColor: Colors.black,
                      //   decoration: const InputDecoration(
                      //     contentPadding: EdgeInsets.only(
                      //         top: 1.0, bottom: 100.0, left: 8.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(15.0)),
                      //     ),
                      //     fillColor: Colors.black,
                      //   ),
                      // ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 2),
                SizedBox(height: 15.h),
                greenButtonLogin('Login', () {
                  final FormState? form = _formKey.currentState;
                  if (form!.validate()) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PageViewScreen.fromBase64(jsonResponse)),
                        (Route<dynamic> route) => false);
                  }
                }),
                SizedBox(height: 25.h),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Text(
                    'FORGOT PASSWORD',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: Text(
                            'SIGN UP',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget greenButtonLogin(text, onTap) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 1],
          colors: [
            Color(0xff0ced10),
            Colors.white,
          ],
        ),
        color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(color: Colors.black, width: 2.5)),
          ),
          minimumSize: MaterialStateProperty.all(Size(200.w, 50.h)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          login(email: loginController.text, password: passwordController.text)
              .then((value) {
            setState(() {
              isLoading = false;
            });
            final responseValue = value.cast<String, dynamic>();
            if (responseValue['success']) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PageViewScreen.fromBase64(jsonEncode(responseValue))),
                  (Route<dynamic> route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(responseValue['message']),
                    backgroundColor:
                        responseValue['success'] ? Colors.green : Colors.red),
              );
            }
          });
        },
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: TextStyle(
                    color: const Color(0xff000000),
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
