// ignore: file_names
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:kelivog/Widget/sixCylinders_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '6kg_sell_details.dart';

class SixCylindersListsScreen extends StatefulWidget {
  final String item, id, title;

  const SixCylindersListsScreen(
      {Key? key, required this.item, required this.id, required this.title})
      : super(key: key);

  @override
  State<SixCylindersListsScreen> createState() =>
      _ThirteenCylinderScreenState();
}

class _ThirteenCylinderScreenState extends State<SixCylindersListsScreen> {
  late final List <Fee> item=[];
  late String myData;
  late Timer timer;
  var thirteenCylinders;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 5), (Timer t) => fetchCylinderDetails());
  }

  // void getServiceFee() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? jwt = prefs.getString('jwt');
  //   Map<String, dynamic> token = jsonDecode(jwt!);
  //   print(token);
  //
  //   final http.Response response = await http.get(
  //       Uri.parse("https://kelivog.com/serviceFee"),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': token['token']
  //       });
  //
  //   if (response.statusCode == 200) {
  //     var responseBody = json.decode(response.body);
  //     print(responseBody);
  //     for (final dynamic item in responseBody['data']) {
  //       final Fee fee = Fee(
  //         fee: item['serviceFee'],
  //       );
  //       item.add(fee);
  //       print(fee);
  //     }
  //     setState(() { });
  //   } else {
  //     throw Exception('Failed to load fee');
  //   }
  // }

  Future fetchCylinderDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');

    Map<String, dynamic> token = jsonDecode(jwt!);
    http.Response myResponse = await http.get(
        Uri.parse('https://kelivog.com/sell/withCategory/${widget.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization": token['token']
        });
    if (myResponse.statusCode == 200) {
      myData = myResponse.body;

      //Map<String, dynamic> thirteenCylinders = jsonDecode(myResponse.body);
      if (kDebugMode) {
        print(myResponse.body);
      }

      setState(() {
        thirteenCylinders = jsonDecode(myData)["data"];

        if (kDebugMode) {
          print(thirteenCylinders.length);
        }
      });

      if (kDebugMode) {
        print(thirteenCylinders[0]['brand']);
      }
    } else {
      if (kDebugMode) {
        print(myResponse.statusCode);
      }
    }
  }

  onGoBack(dynamic value) {
    print('cylindergoing back');
    fetchCylinderDetails();
    setState(() {});
  }

  void inventoryData() {
    Route route = MaterialPageRoute(
        builder: (ctx) => SellDetails(
              id: widget.id,
              item: widget.item,
              title: widget.title,
            ));
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    print('This is the $context');
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              SizedBox(height: 5.h),
              Text(
                '6 KG',
                // jsonDecode(myData)['allCylinders'][1]['capacityName'],
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: const Color(0xff261005),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.h),
              ElevatedButton(
                onPressed: inventoryData,
                child: Text(
                  '+ ADD',
                  style: TextStyle(
                      color: const Color(0xff0ced10), fontSize: 22.sp),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  fixedSize: Size(180.w, 50.h),
                  primary: const Color(0xff261005),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      thirteenCylinders == null ? 0 : thirteenCylinders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SixCylindersCard(
                      //serviceFee: thirteenCylinders[index]['serviceFee'].toString(),
                      brand: thirteenCylinders[index]['brand'],
                      capacityId: thirteenCylinders[index]['capacity'],
                      capacityName: thirteenCylinders[index]['capacityName'],
                      price: thirteenCylinders[index]['price'].toString(),
                      id: thirteenCylinders[index]['_id'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}