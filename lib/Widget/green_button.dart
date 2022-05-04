import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget greenButton(text, onTap) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.2, 1],
        colors: [
          Color(0xff0ced10),
          Colors.white,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(20),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(color: Colors.black, width: 2.5)),
        ),
        minimumSize: MaterialStateProperty.all(Size(200.w, 50.h)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
            color: const Color(0xff000000),
            fontSize: 21.sp,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
