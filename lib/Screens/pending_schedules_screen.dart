import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kelivog/Widget/pending_schedules_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingSchedulesScreen extends StatefulWidget {
  const PendingSchedulesScreen({Key? key}) : super(key: key);

  @override
  State<PendingSchedulesScreen> createState() => _PendingSchedulesScreenState();
}

class _PendingSchedulesScreenState extends State<PendingSchedulesScreen> {
  late Timer timer;
  late List<Pending> items = [];

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
                        'PENDING CONFIRMATIONS',
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

  Future<List<Pending>> getSchedule() async {
    List<Pending> items = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    final http.Response response =
    await http.get(Uri.parse("https://kelivog.com/schedules/incoming"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    });
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
     // print(responseBody['data'][0]);
      responseBody['data'].forEach((item) {
        final Pending schedule = Pending(
          id: item['_id'],
          amount: item['amount'],
          capacity: item['capacity'],
          buyerUserId: item['buyerUserId'],
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
      throw Exception('Failed to load pending schedules');
    }
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Pending> items = snapshot.data;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return PendingSchedulesCard(
          schedule: items[index],
        );
      },
    );
  }
}

class Pending {
  final String id;
  final String capacity;
  final String buyerUserId;
  final String buyerContact;
  final String cylinderId;
  final int amount;
  final String brand;
  final int status;

  Pending({
    required this.id,
    required this.capacity,
    required this.buyerUserId,
    required this.buyerContact,
    required this.cylinderId,
    required this.amount,
    required this.brand,
    required this.status,
  });
}
