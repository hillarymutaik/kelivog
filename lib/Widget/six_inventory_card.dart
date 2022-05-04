import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/6kg_inventory_screen.dart';

class SixInventoryCard extends StatelessWidget {
  final String image, title, ids;
  const SixInventoryCard(
      {Key? key, required this.image, required this.title, required this.ids})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 90.h,
                width: 100.w,
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
                child: Image.asset(
                  image,
                  height: 80.h,
                  width: 120.w,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return SixInventoryCylindersScreen(
                      item: image,
                      id: ids,
                      title: title,
                    );
                  }));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //
                  //         builder: (ctx) => const SixInventoryCylindersScreen(item: '', category: {},)));
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: const Color(0xff0ced10), fontSize: 20.sp),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  fixedSize: Size(180.w, 50.h),
                  primary: const Color(0xff261005),
                ),
              ),
            ],
          ),
          Divider(
            indent: 20.w,
            endIndent: 20.w,
            thickness: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
