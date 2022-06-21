import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Screens/login_screen.dart';
import 'package:kelivog/Screens/page_view_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/validators.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final estateController = TextEditingController();
  final passwordController = TextEditingController();

  TextEditingController loginController = TextEditingController();
  var jsonResponse;
  late ScaffoldMessengerState scaffoldMessenger;

  final Geolocator geolocator = Geolocator();
  Position? _currentPosition;
  String? _currentAddress;
  bool isLoading = false;
  bool isLoggedIN = false;

  // ignore: non_constant_identifier_names
  Future Register() async {
    print("Register...");

    setState(() {
      isLoading = true;
    });

    String name = firstNameController.text + " " + lastNameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passwordController.text;
    String? address = estateController.text; //
    // double latitude = _currentPosition!.latitude; //
    // double longitude = _currentPosition!.longitude; //

    var myData = {
      'name': name,
      'email': email,
      'phonenumber': phone,
      'password': password,
      'address': address,
      // 'latitude': "$latitude",
      // 'longitude': "$longitude"
    };

    print("REgistering...$myData");

    try {
      final response = await http.post(Uri.parse('https://kelivog.com/users'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: jsonEncode(myData),
          encoding: Encoding.getByName("utf-8"));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          isLoggedIN = true;
        });

        Map<String, dynamic> myResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('successfully registered'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        context.read<LoadingProvider>().setLoad(false);
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      // if (kDebugMode) {
      //   print("Oops! Something went wrong. Try again!" + e.toString());
      // }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
      context.read<LoadingProvider>().setLoad(false);
    }
  }

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  // Future _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.deniedForever) {
  //       return Future.error('Location Not Available');
  //     }
  //   } else {
  //     throw Exception('Error');
  //   }
  //   return await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });

  //     _getAddressFromLatLng();
  //   }).catchError((e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   });
  // }

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await placemarkFromCoordinates(
  //         _currentPosition!.latitude, _currentPosition!.longitude);

  //     Placemark place = p[0];

  //     setState(() {
  //       _currentAddress =
  //           "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

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
                    child: Text("FIRSTNAME",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: firstNameController,
                        validator: nameValidator,
                        cursorColor: Colors.black,
                        //showCursor: true,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 10),
                      // child: TextFormField(
                      //   controller: firstNameController,
                      //   validator: nameValidator,
                      //   cursorColor: Colors.black,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         EdgeInsets.symmetric(horizontal: 10.w),
                      //     border: InputBorder.none,
                      //     fillColor: Colors.black,
                      //   ),
                      //   // ),
                      // ),
                    ),
                  ),
                ),
                Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 1.5),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("LASTNAME",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: lastNameController,
                        validator: nameValidator,
                        cursorColor: Colors.black,
                        //showCursor: true,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 10),
                      //   child: TextFormField(
                      //     controller: lastNameController,
                      //     validator: nameValidator,
                      //     cursorColor: Colors.black,
                      //     decoration: InputDecoration(
                      //       contentPadding:
                      //           EdgeInsets.symmetric(horizontal: 10.w),
                      //       border: InputBorder.none,
                      //       fillColor: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 1.5),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("EMAIL",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: emailController,
                        validator: emailValidator,
                        cursorColor: Colors.black,
                        //showCursor: true,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 10),
                      //   child: TextFormField(
                      //     controller: emailController,
                      //     validator: emailValidator,
                      //     cursorColor: Colors.black,
                      //     decoration: InputDecoration(
                      //       contentPadding:
                      //           EdgeInsets.symmetric(horizontal: 10.w),
                      //       border: InputBorder.none,
                      //       fillColor: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 1.5),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("PASSWORD",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: true,
                        controller: passwordController,
                        validator: passwordValidator,
                        cursorColor: Colors.black,
                        //showCursor: true,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 10),
                      //   child: TextFormField(
                      //     obscureText: true,
                      //     controller: passwordController,
                      //     validator: passwordValidator,
                      //     cursorColor: Colors.black,
                      //     decoration: InputDecoration(
                      //       contentPadding:
                      //           EdgeInsets.symmetric(horizontal: 10.w),
                      //       border: InputBorder.none,
                      //       fillColor: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 1.5),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("PHONE",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: phoneController,
                        validator: phoneValidator,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 10),
                      //   child: TextFormField(
                      //     controller: phoneController,
                      //     validator: phoneValidator,
                      //     cursorColor: Colors.black,
                      //     keyboardType: TextInputType.phone,
                      //     decoration: InputDecoration(
                      //       contentPadding:
                      //           EdgeInsets.symmetric(horizontal: 10.w),
                      //       border: InputBorder.none,
                      //       fillColor: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 1.5),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("ESTATE",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: estateController,
                        validator: nameValidator,
                        cursorColor: Colors.black,
                        //showCursor: true,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
                        ),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 10),
                      // child: TextFormField(
                      //   controller: estateController,
                      //   validator: nameValidator,
                      //   cursorColor: Colors.black,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         EdgeInsets.symmetric(horizontal: 10.w),
                      //     border: InputBorder.none,
                      //     fillColor: Colors.black,
                      //   ),
                      // ),
                      // ),
                    ),
                  ),
                ),
                Divider(indent: 0.15.sw, endIndent: 0.15.sw, thickness: 1.5),
                SizedBox(height: 25.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: ElevatedButton(
                    onPressed: () async {
                      final FormState? form = _formKey.currentState;
                      if (form!.validate()) {
                        print("Everything OK..register");
                        context.read<LoadingProvider>().setLoad(true);
                        await Register();
                        // if (isLoggedIN) {
                        //   Navigator.of(context).pushAndRemoveUntil(
                        //       MaterialPageRoute(
                        //           builder: (BuildContext context) =>
                        //               PageViewScreen.fromBase64(jsonResponse)),
                        //       (Route<dynamic> route) => false);
                        // } else {
                        //   print("Unable to register");
                        // }
                      }
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: const Color(0xff0ced10), fontSize: 20.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      fixedSize: Size(160.w, 50.h),
                      primary: const Color(0xff261005),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
