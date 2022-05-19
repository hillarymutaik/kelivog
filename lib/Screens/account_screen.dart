import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Screens/document_screen.dart';
import 'package:kelivog/Screens/login_screen.dart';
import 'package:kelivog/Screens/profile_screen.dart';
import 'package:kelivog/Screens/status_screen.dart';
import 'package:kelivog/Screens/transaction_history_screen.dart';
import 'package:kelivog/Screens/withdraw_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'financial_details.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late Timer _timer;
  String _pic = '0';
  late Future<Profile> futureProfile;
  void loadPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pic = (prefs.getString('pic') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      getProfile()!;
    });
    futureProfile = getProfile()!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          header(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'ACCOUNT',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 29.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //print(_pic);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[700],
                        ),
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xff0ced10), width: 7),
                            color: Colors.green[700],
                          ),
                          child: FutureBuilder<Profile>(
                            future: futureProfile,
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                if (snapshot.hasData) {
                                  print(snapshot.data);
                                  return ClipOval(
                                    child: Image.network(
                                      snapshot.data!.pic,
                                      width: 80.h,
                                      height: 80.h,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  print('error ${snapshot.error}');
                                  Icon(
                                    Icons.person,
                                    size: 65.sp,
                                    color: const Color(0xff0ced10),
                                  );
                                  // return Text('${snapshot.error}')
                                }
                              }

                              print("snaaijsoa " + snapshot.data.toString());

                              // By default, show a loading spinner.
                              return Icon(
                                Icons.person,
                                size: 65.sp,
                                color: const Color(0xff0ced10),
                              );
                            },
                          ),
                          // child: pic != null ?
                          // AssetImage(pic)
                          // :Icon(
                          //   Icons.person,
                          //   size: 65.sp,
                          //   color: const Color(0xff0ced10),
                          // ),
                        ),
                      ),
                      Text(
                        'PROFILE',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          item('DOCUMENTS', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DocumentScreen()));
          }),
          item('TRANSACTION HISTORY', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionHistoryScreen()));
          }),
          item('WITHDRAWAL', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WithdrawScreen()));
          }),
          item('FINANCIALS', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FinancialDetails()));
          }),
          item('STATUS', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StatusScreen()));
          }),
          // item('SHARE APP', () {
          //   Share.share('Download Kelivog app https://play.google.com/');
          // }),
          item('LOG OUT', () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Are you sure you want to log out?'),
              action: SnackBarAction(
                label: 'Yes',
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs
                      .remove('jwt')
                      .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false))
                      .onError((error, stackTrace) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('$error'),
                          )));
                },
              ),
            ));
          }),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: IconButton(
                icon: const Icon(Icons.share),
                iconSize: 40.sp,
                color: Colors.black,
                onPressed: () {
                  Share.share('Download Kelivog Associate App at https://play.google.com/');
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child:
            Divider(indent: 50.w, endIndent: 50.w, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget item(title, onTap) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                title,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Divider(indent: 50.w, endIndent: 50.w, color: Colors.black),
        )
      ],
    );
  }
}

Future<Profile>? getProfile() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jwt = prefs.getString('jwt');
  Map<String, dynamic> token = jsonDecode(jwt!);

  var url = Uri.parse('https://kelivog.com/users/profile');
  final res = await http.Client().get(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": token['token']
      //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWZjZDZiY2JjNTRiNjUwNTcwZTdlZGEiLCJlbWFpbCI6Imtlbm5lZHlfbXdhbmdpQGhvdG1haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsInRva2VuSWQiOiI2MjAxMWVkYTNiZWZhZWRlODVjMGEwOTUiLCJpYXQiOjE2NDQyNDA2MDJ9.spQuGb5qtcaOqI3zjAChdkwmjwjWPliqWH4fBHmAN_0'
    },
  );
  if (res.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseBody = json.decode(res.body);
    print(responseBody['data'][0]);

    final Profile pic = Profile(
      pic: responseBody['data']['linkUrl'],
    );
    return pic;
    // return Profile.fromJson(jsonDecode(res.body["data"]));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pic');
  }
}

class Profile {
  final String pic;

  const Profile({
    required this.pic,
  });

  // factory Profile.fromJson(Map<String, dynamic> json) {
  //   return Profile(
  //     balance: json['balance'].toString(),
  //   );
  // }
}
