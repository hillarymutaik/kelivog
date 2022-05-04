import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelivog/Screens/login_screen.dart';
import 'package:kelivog/Screens/page_view_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? jwt = prefs.getString('jwt');
      //Map<String, dynamic> token = jsonDecode(jwt!);
      if (jwt != null) {
        try {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PageViewScreen.fromBase64(jsonEncode(jwt))),
              (Route<dynamic> route) => false);
        } catch (e) {
          print(e);
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0ced10), Colors.yellow],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png', height: 110, width: 260),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Kelivog Associate.',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(205, 0, 0, 0)),
            ),
            const Text(
              'Taking Your LPG(Gas) Refill Business 24/7',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(205, 0, 0, 0)),
            ),
          ],
        )),
      ),
    );
  }
}
