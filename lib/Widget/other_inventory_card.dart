import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/6kg_inventory_screen.dart';
import 'package:kelivog/Screens/all_cylinders_screen.dart';
import 'package:kelivog/Screens/other_inventory_screen.dart';
import 'package:kelivog/Screens/upload_screen.dart';
import 'package:kelivog/Screens/all_inventory_cylinders_screen.dart';

class OtherInventoryCard extends StatelessWidget {
  final String image, title;
  const OtherInventoryCard(
      {Key? key, required this.image, required this.title, id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                image,
                height: 80.h,
                width: 120.w,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => OtherInventoryCylindersScreen(
                                item: '',
                              )));
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: const Color(0xff0ced10), fontSize: 20.sp),
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
            ],
          ),
          Divider(
            indent: 20.w,
            endIndent: 20.w,
            thickness: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
