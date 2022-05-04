import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:http/http.dart' as http;
import 'package:kelivog/Screens/pending_schedules_screen.dart';
import 'package:kelivog/Widget/green_button.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/profile_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptScreen extends StatefulWidget {
  final Pending schedules;
  const AcceptScreen({Key? key, required this.schedules}) : super(key: key);

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  File? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var jsonResponse;
  bool isLoading = true;
  late ScaffoldMessengerState scaffoldMessenger;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => statusUpdate());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              SizedBox(height: 15.h),
              Container(
                height: 110.h,
                width: 140.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: const Color(0xff0ced10), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(4, 4),
                      blurRadius: 3.r,
                    ),
                  ],
                ),
                child: Center(
                  child: widget.schedules.capacity != '6 Kg'
                      ? Image.asset(
                          'images/13kg.jpg',
                          height: 100.h,
                          width: 100.w,
                        )
                      : Image.asset(
                          'images/6kg.jpg',
                          height: 100.h,
                          width: 100.w,
                        ),
                ),
              ),
              SizedBox(height: 25.h),
              Container(
                width: 350.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  image: const DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, spreadRadius: 2),
                  ],
                ),
                child: ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ProfileCard(
                      title: 'BRAND',
                      answer: widget.schedules.brand,
                    ),
                    //Divider(indent: 15, endIndent: 15, thickness: 3),
                    ProfileCard(
                      title: 'CAPACITY',
                      answer: widget.schedules.capacity,
                    ),
                    //Divider(indent: 15, endIndent: 15, thickness: 3),
                    ProfileCard(
                      title: 'PRICE',
                      answer: widget.schedules.amount.toString(),
                    ),
                    //Divider(indent: 15, endIndent: 15, thickness: 3),
                    ProfileCard(
                      title: 'CLIENT\'S PHONE NO.',
                      answer: widget.schedules.buyerContact,
                    ),
                  ],
                ),
              ),
              const Divider(indent: 15, endIndent: 15, thickness: 3),
              SizedBox(height: 20.h),
              greenButton('ACCEPT', () {
                context.read<LoadingProvider>().setLoad(true);
                statusUpdate().then((value) => {
                      value != 200
                          ? {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const PendingSchedulesScreen())),
                              //Navigator.of(context).pop(),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error occurred',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              //getSchedule()
                            }
                          : {
                             //Navigator.of(context).pop(),
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(
                                builder: (ctx) => PendingSchedulesScreen())),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Purchase process successfully accepted',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            },
                    });
                context.read<LoadingProvider>().setLoad(false);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> statusUpdate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    Map<String, dynamic> body = {
      "status": 4,
    };
    var url = Uri.parse('https://kelivog.com/schedules/changeStatus/${widget.schedules.id}');
    final putRequestResponse = await http.Client().put(
      url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    },
      body: jsonEncode(body),
    );
    return putRequestResponse.statusCode;
  }
}
