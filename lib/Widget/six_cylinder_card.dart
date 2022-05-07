import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Screens/6kg_cylinder_screen.dart';
//import 'package:kelivog/Screens/all_cylinders_screen.dart';

class SixCylinderCard extends StatelessWidget {
  final String id, image, title;
  //final double serviceFee ;
  const SixCylinderCard(
      {Key? key,
        required this.image,
        required this.title,
        required this.id,
       // required this.serviceFee
      })
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
                child: const Center(
                    child: Image(
                  image: AssetImage('images/6kg.jpeg'),
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => SixCylindersListsScreen(
                              item: image, id: id, title: title)));
                },
                child: Text(title,
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
          SizedBox(
            height: 20.h,
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


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kelivog/Screens/6kg_cylinder_screen.dart';
//
// class SixCylinderCard extends StatelessWidget {
//   final String image, title;
//   const SixCylinderCard({Key? key, required this.image, required this.title})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Image.asset(
//                 image,
//                 height: 80.h,
//                 width: 120.w,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (ctx) => const SixCylindersListsScreen(item: '',)));
//                 },
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                       color: const Color(0xff0ced10), fontSize: 20.sp),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.r),
//                   ),
//                   fixedSize: Size(180.w, 50.h),
//                   primary: const Color(0xff261005),
//                 ),
//               ),
//             ],
//           ),
//           Divider(
//             indent: 20.w,
//             endIndent: 20.w,
//             thickness: 1,
//             color: Colors.black,
//           )
//         ],
//       ),
//     );
//   }
// }
