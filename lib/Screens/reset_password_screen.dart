import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelivog/Screens/page_view_screen.dart';
import 'package:kelivog/Widget/green_button.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/validators.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

Future<dynamic> resetPasswordHttp(
    {String? userEmail,
    String? code,
    String? password,
    String? confirmPassword}) async {
  Map<String, dynamic> body = {
    'email': userEmail,
    "code": code,
    "password": password,
    "confirm": confirmPassword,
  };
  var url = Uri.parse('https://kelivog.com/users/reset');
  final postResetPasswordResponse = await http.Client().post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  Map<String, dynamic> forgotPasswordResponse = {
    'message': jsonDecode(postResetPasswordResponse.body)['message'],
    'success': jsonDecode(postResetPasswordResponse.body)['success'],
  };
  return forgotPasswordResponse;
}

class ResetPassword extends StatefulWidget {
  final String userEmail;

  const ResetPassword({Key? key, required this.userEmail}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final inputCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;

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
                  SizedBox(height: 60.h),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                      child: Text("Forgot your Password?",
                          style: TextStyle(
                              fontSize: 26.sp, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                      child: Text(
                          "Enter the code sent to your email to reset your password",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.normal)),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                      child: Text("CODE",
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                            color: Colors.yellow),
                        width: 0.75.sw,
                        height: 65.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: inputCodeController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
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
                  Card(
                    color: const Color(0xff0ced10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                            color: Colors.yellow),
                        width: 0.75.sw,
                        height: 65.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: TextFormField(
                            obscureText: true,
                            validator: passwordValidator,
                            controller: passwordController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                      child: Text("CONFIRM PASSWORD",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Card(
                    color: const Color(0xff0ced10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                            color: Colors.yellow),
                        width: 0.75.sw,
                        height: 65.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: TextFormField(
                            obscureText: true,
                            validator: passwordValidator,
                            controller: confirmPasswordController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 2),
                  SizedBox(height: 25.h),
                  greenButton('SUBMIT', () {
                    final FormState? form = _formKey.currentState;
                    if (form!.validate()) {}
                  }),
                ],
              ),
            ),
          ),
        ));
  }

  Widget greenButton(text, onTap) {
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
          resetPasswordHttp(
                  userEmail: widget.userEmail,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                  code: inputCodeController.text)
              .then((value) {
            setState(() {
              isLoading = false;
            });
            final responseValue = value.cast<String, dynamic>();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(responseValue['message']),
                  backgroundColor:
                      responseValue['success'] ? Colors.green : Colors.red),
            );
            if (responseValue['success']) {
              Timer(const Duration(seconds: 3), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LoginScreen()));
              });
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
