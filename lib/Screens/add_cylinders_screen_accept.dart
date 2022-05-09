import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCylindersScreenAccept extends StatelessWidget {
  const AddCylindersScreenAccept({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              SizedBox(height: 15.h),
              Container(
                height: 140.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.yellow,
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
                child: Center(
                    child: SvgPicture.asset(
                  'images/gas2.svg',
                  width: 80.w,
                  height: 80.h,
                )),
              ),
              SizedBox(height: 25.h),
              item('BRAND'),
              item('CAPACITY'),
              item('PRICE'),
              item('BUYER\'S NAME'),
              item('BUYER\'S CONTACT'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
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
                            side: const BorderSide(
                                color: Colors.black, width: 2.5)),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(200.w, 50.h)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: Text(
                      'ACCEPT',
                      style: TextStyle(
                          color: const Color(0xff000000),
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(text) {
    return Column(
      children: [
        Text(text,
            style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: Container(
            width: 0.9.sw,
            height: 40.h,
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(15)),
            child: const Center(child: Text('')),
          ),
        ),
        Divider(indent: 15.w, endIndent: 15.w, thickness: 2)
      ],
    );
  }
}
