import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/sell_cylinder_screen.dart';
import 'package:kelivog/Widget/header.dart';

class CylinderScreen extends StatelessWidget {
  const CylinderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        SizedBox(height: 30.h),
        SizedBox(
          width: 0.9.sw,
          height: 0.6.sh,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: const [0.01, 0.01],
                  colors: [Colors.green[800]!, Colors.grey]),
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                elevation: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    image: const DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 45.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          SellCylinderScreen()));
                            },
                            child: Text(
                              'SELL',
                              style: TextStyle(
                                  color: const Color(0xff0ced10),
                                  fontSize: 22.sp),
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
                  ),
                )),
          ),
        )
      ],
    );
  }
}
