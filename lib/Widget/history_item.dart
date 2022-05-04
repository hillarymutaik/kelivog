import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget historyItem(text, String string, [double? height = 40]) {
  return Column(
    children: [
      Text(text,
          style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        child: Container(
          width: 1.sw,
          height: height,
          decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.circular(15)),
          child: Center(child: Text(string)),
        ),
      ),
      SizedBox(height: 5.h),
    ],
  );
}
