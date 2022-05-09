import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/newallstage_screen.dart';
import 'package:kelivog/Screens/sale_completed.dart';

class NewSchedulesCard extends StatelessWidget {
  final Cylinder cylinder;
  const NewSchedulesCard({Key? key, required this.cylinder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cylinder;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (ctx) => SaleCompleted(
          //       cylinder: cylinder,
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
              onTap: () {},
              child: Container(
                height: 120,
                width: 120,
                child: cylinder.capacityName == "6 Kg"
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
                // child: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     color: Colors.white,
                //   ),
                // ),
              ),
            ),
            Column(
              children: [
                rowItem('BRAND', value: cylinder.brand),
                rowItem('CAPACITY', value: cylinder.capacityName),
                rowItem('AMOUNT', value: cylinder.price.toString()),
                rowItem('PURCHASE \n STATUS',
                    value: cylinder.isSold ? 'PROCESSING' : 'COMPLETE'),
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
              width: 0.2.sw,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              )),
          SizedBox(width: 5.w),
          SizedBox(
            width: 0.2.sw,
            child: Container(
              width: 95.w,
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
}
