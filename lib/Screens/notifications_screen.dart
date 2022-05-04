import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          header(),
          SizedBox(height: 15.h),
          Text('NOTIFICATIONS',
              style: TextStyle(
                color: Colors.green,
                fontSize: 29.sp,
                fontWeight: FontWeight.bold,
              )),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 15.h),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 15.h),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 15.h),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 15.h),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 15.h),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 15.h),
          const Divider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 15.h),
        ])),
      ),
    );
  }
}
