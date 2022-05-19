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
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => getStage());
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


  Widget schedulesCard({required Cylinder schedule}) {
    var transaction = schedule;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        width: 0.97.sw,
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
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(
                //             builder: (ctx) => CollectCylinderScreen(
                //                 schedule: schedule)));
                //   },),
                SizedBox(width: 0.01.sw,),
                  Container(
                    height: 80,
                    width: 60,
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
                 SizedBox(width: 0.03.sw,),
                 Column(children: [
                    rowItem('BRAND', details: transaction.brand),
                    rowItem('CAPACITY', details: transaction.capacityName),
                    rowItem('AMOUNT', details: transaction.price.toString()),
                    rowItem('PHONE NO.', details: transaction.buyerContact),
                    // rowItem('PURCHASE \n STATUS',
                    //     value: transaction.isSold ? 'PROCESSING' : 'COMPLETE'),
                  ],
                )
             ]
            ),
          ),
        ),
      ),
    );
  }

  rowItem(String name, {required String details}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(width: 0.2.sw, child: Text(name)),
          SizedBox(width: 0.05.sw,),
          SizedBox(
            width: 0.5.sw,
            child: Container(
              width: 80.w,
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
    List<Cylinder> items = snapshot.data;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return schedulesCard(schedule: items[index]);
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
      { //required this.refId,
      required this.capacity,
      required this.userId,
      required this.buyerContact,
      required this.capacityName,
      required this.price,
      required this.id,
      required this.brand,
      required this.isSold});
}
