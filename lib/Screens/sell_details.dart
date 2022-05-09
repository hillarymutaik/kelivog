import 'package:flutter/material.dart';
import 'package:kelivog/Screens/purchase_success_screen.dart';
import 'package:kelivog/Screens/save_delete_screen.dart';
import 'package:kelivog/Widget/edit_image.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellDetails extends StatelessWidget {
  const SellDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        // body: SingleChildScrollView(
        body: Column(
          children: [
            header(),
            SizedBox(height: 30.h),
            //const EditImage(),
            // Container(
            //   height: 120.h,
            //   width: 150.w,
            //   clipBehavior: Clip.antiAlias,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(15.r),
            //     border: Border.all(color: const Color(0xff0ced10), width: 2),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black,
            //         offset: const Offset(4, 4),
            //         blurRadius: 3.r,
            //       ),
            //     ],
            //   ),
            //   child: Container(
            //     height: 125.h,
            //     width: 125.w,
            //     color: Colors.white,
            //   ),
            // ),
            SizedBox(height: 40.h),
            Container(
              width: 350.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                image: const DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, spreadRadius: 2),
                ],
              ),
              child: Column(
                children: [
                  rowItem('BRAND'),
                  rowItem('CAPACITY'),
                  rowItem('AMOUNT'),
                  rowItem('SERVICE FEE'),
                  rowItem('TAKE HOME'),
                ],
              ),
            ),

            SizedBox(height: 50.h),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (ctx) => const SaveDeleteScreen()));
              },
              child: Text(
                'UPLOAD',
                style: TextStyle(
                  color: Colors.yellow[600],
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                fixedSize: Size(150.w, 50.h),
                primary: const Color(0xff261005),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowItem(text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Container(
              width: 95.w,
              height: 25.h,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(child: Text('')),
            ),
          ),
        ],
      ),
    );
  }
}
