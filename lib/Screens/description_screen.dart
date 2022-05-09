import 'package:flutter/material.dart';
import 'package:kelivog/Screens/purchase_success_screen.dart';
import 'package:kelivog/Screens/sell_details.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: Column(
          children: [
            header(),
            SizedBox(height: 40.h),
            // const EditImage(),

            Text(
              'DESCRIPTION',
              style: TextStyle(
                color: const Color(0xFF000000),
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 50.h),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    stops: [0.01, 0.02], colors: [Colors.green, Colors.grey]),
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Container(
                    width: 300.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      image: const DecorationImage(
                        image: AssetImage("images/background.jpg"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          rowItem('BRAND'),
                          rowItem('CAPACITY'),
                          rowItem('AMOUNT'),
                        ],
                      ),
                    ),
                  )),
            ),
            SizedBox(height: 50.h),
            Container(
              height: 120.h,
              width: 150.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Container(
                height: 125.h,
                width: 125.w,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 35.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const SellDetails()));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (ctx) => const PurchaseSuccessScreen()));
              },
              child: Text(
                'NEXT',
                style:
                    TextStyle(color: const Color(0xff0ced10), fontSize: 22.sp),
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
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(child: Text('')),
            ),
          ),
        ],
      ),
    );
  }
}
