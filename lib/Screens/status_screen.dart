// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  //bool activeStat = false;
  bool onlineStat = false;

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: Column(
          children: [
            header(),
            SizedBox(height: 50.h),
            Text(
              'ACTIVE STATUS',
              style: TextStyle(
                  color: const Color(0xff261005),
                  fontSize: 27.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => {
                // setState(() {
                //   activeStat = !activeStat;
                // })
              },
              child: Text(
                'ACTIVE',
                style:
                    TextStyle(color: const Color(0xff0ced10), fontSize: 20.sp),
              ),
              // child: activeStat
              //      Text(
              //         'ACTIVE',
              //         style: TextStyle(
              //             color: const Color(0xff0ced10), fontSize: 20.sp),
              //       )
              // : Text(
              //     'INACTIVE',
              //     style: TextStyle(
              //         color: const Color(0xff0ced10), fontSize: 20.sp),
              //   ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                fixedSize: Size(220.w, 60.h),
                primary: const Color(0xff261005),
              ),
            ),
            SizedBox(height: 80.h),
            Divider(thickness: 2, indent: 15.w, endIndent: 15.w),
            SizedBox(height: 80.h),
            Text(
              'ONLINE STATUS',
              style: TextStyle(
                  color: const Color(0xff261005),
                  fontSize: 27.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  onlineStat = !onlineStat;
                }),
                changeStatus(onlineStat)
                //print(onlineStat)   //true or false
              },
              child: onlineStat
                  ? Text(
                      'ONLINE',
                      style: TextStyle(
                          color: const Color(0xff0ced10), fontSize: 20.sp),
                    )
                  : Text(
                      'OFFLINE',
                      style: TextStyle(
                          color: const Color(0xff0ced10), fontSize: 20.sp),
                    ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                fixedSize: Size(220.w, 60.h),
                primary: const Color(0xff261005),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeStatus(bool onlineStat) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('status', onlineStat ? 'online' : 'offline');
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    var url = Uri.parse('https://kelivog.com/users/status');
    final res = await http.Client().put(url, headers: {
      'Authorization': token['token'],
      'Content-Type': 'application/json'
    });
    // final String? jwt = prefs.getString('jwt');
    // Map<String, dynamic> token = jsonDecode(jwt!);
    // Map<String, Object> body = {
    //   'onlineStatus': onlineStat ? 'online' : 'offline',
    // };
  }

  Future<void> getStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? status = prefs.getString('status');
    if (status == 'online') {
      setState(() {
        onlineStat = true;
      });
    } else {
      setState(() {
        onlineStat = false;
      });
    }
    Map<String, dynamic> token = jsonDecode(status!);
    Map<String, Object> body = {
      'onlineStatus': onlineStat ? 'online' : 'offline',
    };
  }
}

// changeStatus(bool onlineStat) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? jwt = prefs.getString('jwt');
//   Map<String, dynamic> token = jsonDecode(jwt!);
//   Map<String, Object> body = {
//     'onlineStatus': onlineStat ? 'online' : 'offline',
//   };
//   var url = Uri.parse('https://kelivog.com/users/status');

//   final res = await http.Client().get(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': token['token']
//     },
//   );

//   // var res = await http.Client().post(Uri.parse(url), );
//   if (res.statusCode == 200) {
//     final data = json.decode(res.body);
//     data['data'].length == 0
//         ? await http.Client()
//             .post(
//               url,
//               headers: {
//                 'Content-Type': 'application/json; charset=UTF-8',
//                 'Authorization': token['token']
//               },
//               body: jsonEncode(body),
//             )
//             .then((value) => {
//                   if (value.statusCode == 200)
//                     {print("SUCCESS Post"), print(jsonEncode(body))}
//                   else
//                     {print("FAILED")}
//                 })
//         : await http.Client()
//             .put(
//               url,
//               headers: {
//                 'Content-Type': 'application/json; charset=UTF-8',
//                 'Authorization': token['token']
//               },
//               body: jsonEncode(body),
//             )
//             .then((value) => {
//                   if (value.statusCode == 200)
//                     {
//                       print("SUCCESS Put"),
//                       print(jsonEncode(body)),
//                     }
//                   else
//                     {print("FAILED")}
//                 });

//     return res.statusCode;
//   } else {
//     print(res.statusCode);
//     throw Exception('Failed to update Profile.' '${res.body}');
//   }
// }
