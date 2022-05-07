import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/6kg_cylinder_screen.dart';

class CylinderCard extends StatelessWidget {
  final String image, title;
  final double serviceFee;
  const CylinderCard({Key? key, required this.image, required this.title, required this.serviceFee})
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
                          builder: (ctx) => SixCylindersListsScreen(
                                item: '',
                                id: '',
                                title: '',
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
