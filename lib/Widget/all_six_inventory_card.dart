import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kelivog/Screens/save_delete_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kelivog/Screens/withdraw_screen.dart';

class AllSixInventoryCard extends StatelessWidget {
  final String brand, price, capacity, id, capacityId;
  const AllSixInventoryCard(
      {Key? key,
      required this.id,
      required this.price,
      required this.capacityId,
      required this.brand,
      required this.capacity})
      : super(key: key);

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
                    //Navigator.pushNamed(context, '/inventory').then((_) => setState(() {}));
                    //Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => SaveDeleteScreen(
                                  item: 'images/6kg.jpeg',
                                  id: id,
                                  title: capacity,
                                  brand: brand,
                                  capacity: capacity,
                                  price: price,
                                  capacityId: capacityId,
                                )));
                  },
                  child: Image.asset(
                    'images/6kg.jpeg',
                    height: 80.h,
                    width: 50.w,
                  ),
                ),
                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('BRAND'),
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
                                    brand,
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ),
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
                                    capacity,
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ),
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
                                    price,
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ),
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
