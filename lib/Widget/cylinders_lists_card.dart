import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kelivog/Screens/collect_cylinder_screen.dart';
import 'package:kelivog/Screens/save_delete_cylinder_details.dart';
import 'package:kelivog/Screens/sell_details.dart';

class CylindersListsCard extends StatelessWidget {
  const CylindersListsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        width: 0.85.sw,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                stops: [0.01, 0.01], colors: [Colors.green, Colors.grey]),
            // border: const Border(
            //     bottom: BorderSide(color: Colors.grey, width: 2),
            //     right: BorderSide(color: Colors.grey, width: 2),
            //     top: BorderSide(color: Colors.grey, width: 2)),
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          child: Card(
            elevation: 3,
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                const SaveDeleteCylinderDetails()));
                  },
                  child: SvgPicture.asset(
                    'images/gas.svg',
                    height: 90,
                    width: 90,
                    color: Colors.blue[800],
                  ),
                ),
                Column(
                  children: [
                    rowItem('BRAND'),
                    rowItem('CAPACITY'),
                    rowItem('AMOUNT'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowItem(text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 0.2.sw, child: Text(text)),
          SizedBox(width: 5.w),
          SizedBox(
            width: 0.2.sw,
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
