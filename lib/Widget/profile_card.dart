import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCard extends StatelessWidget {
  final String? title, answer;
  const ProfileCard({Key? key, required this.title, required this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 5.h),
            child: Text(
              title!,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            width: 250.w,
            height: 45.h,
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: 1.0, bottom: 6.0, left: 8.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  hintText: answer,
                  hintStyle: TextStyle(fontSize: 15.sp),
                ),
              ),
            ),
          ),
        ),
        // const Divider(
        //   thickness: 2,
        //   indent: 50,
        //   endIndent: 50,
        // )
      ],
    );
  }
}
