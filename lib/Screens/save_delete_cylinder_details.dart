import 'package:flutter/material.dart';
import 'package:kelivog/Widget/edit_image.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/validators.dart';

class SaveDeleteCylinderDetails extends StatelessWidget {
  const SaveDeleteCylinderDetails({Key? key}) : super(key: key);

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
              SizedBox(height: 30.h),
              //const EditImage(),
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
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("BRAND",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        Container(
                          height: 25.h,
                          width: 180.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.yellow,
                          ),
                          child: TextFormField(
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                            validator: brandValidator,
                            // controller: loginController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.black26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("CAPACITY",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        Container(
                          height: 25.h,
                          width: 160.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.yellow,
                          ),
                          child: TextFormField(
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                            // validator: nameValidator,0xff0ced10
                            // controller: loginController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.black26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("AMOUNT",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        Container(
                          height: 25.h,
                          width: 160.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.yellow,
                          ),
                          child: TextFormField(
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                            // validator: nameValidator,0xff0ced10
                            // controller: loginController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.black26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    rowItem('SERVICE FEE'),
                    rowItem('TAKE HOME'),
                  ],
                ),
              ),

              // SizedBox(height: 50.h),
              // ElevatedButton(
              //   onPressed: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (ctx) => const SaveDeleteScreen()));
              //   },
              //   child: Text(
              //     'UPLOAD',
              //     style: TextStyle(
              //       color: Colors.yellow[600],
              //       fontSize: 22.sp,
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     elevation: 5,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.r),
              //     ),
              //     fixedSize: Size(150.w, 50.h),
              //     primary: const Color(0xff261005),
              //   ),
              // ),

              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
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
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (ctx) => const PurchaseSuccessScreen()));
                    },
                    child: Text(
                      'DELETE',
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
            ],
          ),
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
              width: 90.w,
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
