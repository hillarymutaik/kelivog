import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kelivog/Screens/pending_schedules_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'active_schedules_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Geolocator geolocator = Geolocator();
  Position? _currentPosition;
  String? _currentAddress;

  Future <dynamic> _getCurrentLocation() async {
    bool serviceEnabled;

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? jwt = prefs.getString('jwt');
    // Map<String, dynamic> token = jsonDecode(jwt!);
    //
    // double latitude = _currentPosition!.latitude; //
    // double longitude = _currentPosition!.longitude; //
    //
    // Map<String, dynamic> body = { 'latitude': "$latitude", 'longitude': "$longitude"};
    // var url = Uri.parse('https://kelivog.com/location/associate');
    // final postRequestResponse = await http.Client().post(
    //     url, headers: {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Authorization': token['token']
    // },
    //     body: jsonEncode(body),encoding: Encoding.getByName("utf-8")
    // );
    // var data = json.decode(postRequestResponse.body);
    // print(data);

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          header(),
          GestureDetector(
              onTap: () {
                _getCurrentLocation();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => ActiveSchedulesScreen()));
              },
              child: containerItem()),
          SizedBox(height: 25.h),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const PendingSchedulesScreen()));
              },
              child: containerItem1()),
        ],
      ),
    );
  }

  Widget containerItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Card(
        color: const Color(0xff0ced10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              color: Colors.yellow,
            ),
            width: 1.sw,
            height: 65.h,
            child: const Center(child: Text('ACTIVE SCHEDULES')),
          ),
        ),
      ),
    );
  }

  Widget containerItem1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Card(
        color: const Color(0xff0ced10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              // border: Border(
              //   bottom: BorderSide(color: Colors.green, width: 2),
              // ),
              color: Colors.yellow,
            ),
            width: 1.sw,
            height: 65.h,
            child: const Center(child: Text('PENDING CONFIRMATIONS')),
          ),
        ),
      ),
    );
  }
}
