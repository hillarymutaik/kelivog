import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/header.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                  child: Text(
                    'CHAT BOX',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        stops: [0.01, 0.02],
                        colors: [Colors.green, Colors.grey]),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                        image: const DecorationImage(
                          image: AssetImage("images/background.jpg"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      height: 250.h,
                      width: 250.w,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        controller: messageController,
                        maxLines: 12,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                          ),
                        ),
                      ),
                    ),
                    /*child: SizedBox(
                      height: 250.h,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        controller: messageController,
                        maxLines: 12,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                          ),
                        ),
                      ),
                    ),*/
                  ),
                ),
              ),
              SizedBox(height: 100.h),
              Divider(
                thickness: 2,
                indent: 15.w,
                endIndent: 15.w,
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'SEND',
                      style: TextStyle(
                          color: const Color(0xff0ced10), fontSize: 16.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(100.w, 40.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      primary: const Color(0xff261005),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
