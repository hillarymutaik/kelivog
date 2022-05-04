import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/pending_schedules_screen.dart';
import 'package:kelivog/Widget/header.dart';

import 'active_schedules_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          header(),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => ActiveSchedulesScreen()));
              },
              child: containerItem()),
          SizedBox(height: 25.h),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const PendingSchedulesScreen()));
              },
              child: containerItem1()),
        ],
      ),
    );
  }

  Widget containerItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Card(
        color: const Color(0xff0ced10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              color: Colors.yellow,
            ),
            width: 1.sw,
            height: 65.h,
            child: const Center(child: Text('ACTIVE SCHEDULES')),
          ),
        ),
      ),
    );
  }

  Widget containerItem1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Card(
        color: const Color(0xff0ced10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              // border: Border(
              //   bottom: BorderSide(color: Colors.green, width: 2),
              // ),
              color: Colors.yellow,
            ),
            width: 1.sw,
            height: 65.h,
            child: const Center(child: Text('PENDING CONFIRMATIONS')),
          ),
        ),
      ),
    );
  }
}
