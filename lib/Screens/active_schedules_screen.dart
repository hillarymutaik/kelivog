import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kelivog/Screens/collect_cylinder_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ActiveSchedulesScreen extends StatefulWidget {
  const ActiveSchedulesScreen({Key? key}) : super(key: key);

  @override
  State<ActiveSchedulesScreen> createState() => _PendingSchedulesScreenState();
}

class _PendingSchedulesScreenState extends State<ActiveSchedulesScreen> {
  late Timer timer;
  late List<Schedule> items = [];

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) => getSchedule());
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
              Column(
                children: [
                  header(),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                      child: Text(
                          'ACTIVE SCHEDULES',
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: FutureBuilder(
                      future: getSchedule(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  "No Data",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            } else {
                              return createListView(context, snapshot);
                            }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Schedule>> getSchedule() async {
    List<Schedule> items = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);

    final http.Response response =
    await http.get(Uri.parse("https://kelivog.com/schedules/active"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    });
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      print(responseBody['data'][0]);
      responseBody['data'].forEach((item) {
        final Schedule schedule = Schedule(
          id: item['_id'],
          amount: item['amount'],
          capacity: item['capacity'],
          //buyerUserId: item['buyerUserId'],
          buyerContact: item['buyerContact'],
          cylinderId: item['cylinderId'],
          status: item['status'],
          brand: item['brand'],
        );
        print(schedule);
        items.add(schedule);
      });
      return items;
    } else {
      throw Exception('Failed to load album');
    }
  }

    Widget schedulesCard({required Schedule schedule}) {
    var transaction = schedule;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        width: 0.85.sw,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                stops: [0.01, 0.01], colors: [Colors.green, Colors.grey]),
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          child: Card(
            elevation: 3,
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => CollectCylinderScreen(
                               schedule: schedule)));
                  },
                  child: transaction.capacity != '6 Kg'
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
                Column(
                  children: [
                    rowItem('BRAND', details: transaction.brand),
                    rowItem('CAPACITY', details: transaction.capacity),
                    rowItem('AMOUNT', details: transaction.amount.toString()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  rowItem(String name, {required String details}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          SizedBox(width: 0.2.sw, child: Text(name)),
          SizedBox(width: 5.w),
          SizedBox(
            width: 0.2.sw,
            child: Container(
              width: 95.w,
              height: 25.h,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(15)),
              child: Center(child: Text(details)),
            ),
          ),
        ],
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Schedule> items = snapshot.data;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return schedulesCard(
          schedule: items[index],
        );
      },
    );
  }
}

class Schedule {
  final String id;
  final String capacity;
  //final String buyerUserId;
  final String buyerContact;
  final String cylinderId;
  final int amount;
  final String brand;
  final int status;

  Schedule({
    required this.id,
    required this.capacity,
    //required this.buyerUserId,
    required this.buyerContact,
    required this.cylinderId,
    required this.amount,
    required this.brand,
    required this.status,
  });
}

