import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kelivog/Screens/sale_completed.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/newschedules_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAllStageScreen extends StatefulWidget {
  const NewAllStageScreen({Key? key}) : super(key: key);

  @override
  State<NewAllStageScreen> createState() => _PendingSchedulesScreenState();
}

class _PendingSchedulesScreenState extends State<NewAllStageScreen> {
  late Timer timer;
  late List<Cylinder> items = [];

  get schedule => null;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) => getStage());
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
                          'ONGOING PURCHASES',
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: FutureBuilder(
                      future: getStage(),
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

  Future<List<Cylinder>> getStage() async {
    List<Cylinder> items = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);

    final http.Response response =
    await http.get(Uri.parse("https://kelivog.com/sell"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    });
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      print(responseBody['data'][0]);
      responseBody['data'].forEach((item) {
        final Cylinder schedule = Cylinder(
          id: item['_id'],
          capacity: item['capacity'],
          //buyerUserId: item['buyerUserId'],
          buyerContact: item['buyerNumber'],
         // cylinderId: item['cylinderId'],
          //status: item['status'],
          brand: item['brand'],
            price: item['price'],
            userId: item['userId'],
            capacityName: item['capacityName'],
            isSold: item['isSold'],
        );
        print(schedule);
        items.add(schedule);
      });
      return items;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Widget newSchedulesCard({required Cylinder schedule}) {
    var transaction = schedule;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (ctx) => SaleCompleted(
          //       cylinder: schedule,
          //     ),
          //   ),
          // );
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (ctx) => const DescriptionScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (ctx) => SaleCompleted(),
                //   ),
                // );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (ctx) => const DescriptionScreen()));
              },
              child: Container(
                height: 120,
                width: 120,
                child: transaction.capacityName == "6 Kg"
                    ? Image.asset(
                  "images/6kg.jpg",
                  fit: BoxFit.contain,
                )
                    : Image.asset(
                  "images/13kg.jpg",
                  fit: BoxFit.contain,
                ),

                clipBehavior: Clip.antiAlias,
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
              ),
            ),
            Column(
              children: [
                rowItem('BRAND', value: transaction.brand),
                rowItem('CAPACITY', value: transaction.capacityName),
                rowItem('AMOUNT', value: transaction.price.toString()),
                rowItem('PHONE NO.', value: transaction.buyerContact),

                // rowItem('PURCHASE \n STATUS',
                //     value: transaction.isSold ? 'PROCESSING' : 'COMPLETE'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget rowItem(text, {required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 0.1.sw,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              )),
          // SizedBox(width: 5.w),
          SizedBox(
            width: 0.40.sw,
            child: Container(
              width: 90.w,
              height: text == 'PURCHASE STATUS' ? 40.h : 20.h,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(5)),
              child: Center(child: Text(value)),
            ),
          ),
        ],
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Cylinder> items = snapshot.data;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return newSchedulesCard(
          schedule: items[index]);
      },
    );
  }
}

class Cylinder {
 // final String refId;
  final String id;
  final String capacity;
  final String userId;
  final String capacityName;
  final int price;
  final String buyerContact;
  final String brand;
  final bool isSold;
  Cylinder(
      {//required this.refId,
      required this.capacity,
      required this.userId,
      required this.buyerContact,
      required this.capacityName,
      required this.price,
      required this.id,
      required this.brand,
      required this.isSold
      });
}
