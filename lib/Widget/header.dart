import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget header() {
  return Padding(
    padding: const EdgeInsets.only(top: 25.0),
    child: Column(
      children: [
        Image.asset(
          'images/logo.png',
          height: 65.h,
          width: 65.w,
        ),
        // FlutterLogo(size: 45),
        const Text('KELIVOG'),
        const Divider(
          indent: 20,
          color: Colors.black,
          endIndent: 20,
        )
      ],
    ),
  );
}
