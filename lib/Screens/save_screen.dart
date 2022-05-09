import 'package:flutter/material.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({Key? key}) : super(key: key);

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
            //const EditImage(),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      stops: const [0.01, 0.02],
                      colors: [Colors.green[800]!, Colors.grey]),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    ),
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                        image: const DecorationImage(
                          image: AssetImage("images/background.jpg"),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          rowItem('BRAND'),
                          rowItem('CAPACITY'),
                          rowItem('AMOUNT'),
                        ],
                      ),
                    )),
              ),
            ),
            // Container(
            //   width: 350.w,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.centerLeft,
            //         stops: const [0.1, 0.1],
            //         colors: [Colors.green[800]!, Colors.grey]),
            //     borderRadius: BorderRadius.all(Radius.circular(15.r)),
            //   ),
            //   child: Column(
            //     children: [
            // rowItem('BRAND'),
            // rowItem('CAPACITY'),
            // rowItem('AMOUNT'),
            //     ],
            //   ),
            // ),
            SizedBox(height: 50.h),
            Divider(indent: 15.w, endIndent: 15.w, thickness: 2),
            SizedBox(height: 50.h),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (ctx) => const SaleCompleted(),
                //   ),
                // );
              },
              child: Text(
                'SAVE',
                style: TextStyle(
                  color: const Color(0xff0ced10),
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
