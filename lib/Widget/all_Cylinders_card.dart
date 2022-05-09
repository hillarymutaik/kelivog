import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kelivog/Screens/save_delete_screen.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AllCylindersCard extends StatefulWidget {
  const AllCylindersCard({Key? key}) : super(key: key);

  @override
  _AllCylindersCardState createState() => _AllCylindersCardState();
}

class _AllCylindersCardState extends State<AllCylindersCard> {
  late String myData;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var cylinders_length;
  @override
  void initState() {
    super.initState();
    getInventory();
  }

  void getInventory() async {
    http.Response myResponse = await http
        .get(Uri.parse('https://kelivog.com/sell/61ed7fa0ce1fd097aa002a3d'));
    if (myResponse.statusCode == 200) {
      myData = myResponse.body; //store response as string
      setState(() {
        cylinders_length = jsonDecode(myData)[
            'allCapacities']; //get all the data from json string all capacities
        if (kDebugMode) {
          print(cylinders_length.length);
        } // just printed length of data
      });
      var cylinders = jsonDecode(myData)['allCapacities'][1]['capacityName'];
      if (kDebugMode) {
        print(cylinders);
      }
    } else {
      if (kDebugMode) {
        print(myResponse.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        width: 0.85.sw,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                stops: [0.01, 0.01], colors: [Colors.green, Colors.grey]),
            // border: const Border(
            //     bottom: BorderSide(color: Colors.grey, width: 2),
            //     right: BorderSide(color: Colors.grey, width: 2),
            //     top: BorderSide(color: Colors.grey, width: 2)),
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (ctx) =>  SaveDeleteScreen()));
                  },
                  child: SvgPicture.asset(
                    'images/6kg.jpeg',
                    height: 90,
                    width: 90,
                    color: Colors.blue[800],
                  ),
                ),
                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('BRAND'),
                          SizedBox(
                            width: 0.2.sw,
                            child: Container(
                              width: 95.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  jsonDecode(myData)['allCapacities'][0]
                                      ['capacityName'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('CAPACITY'),
                          SizedBox(
                            width: 0.3.sw,
                            child: Container(
                              width: 90.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  jsonDecode(myData)['allCapacities'][1]
                                      ['capacityName'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('AMOUNT'),
                          SizedBox(
                            width: 0.3.sw,
                            child: Container(
                              width: 90.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  jsonDecode(myData)['allCapacities'][2]
                                      ['capacityName'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ]),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowItem(text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 0.2.sw, child: Text(text)),
          SizedBox(width: 5.w),
        ],
      ),
    );
  }
}
