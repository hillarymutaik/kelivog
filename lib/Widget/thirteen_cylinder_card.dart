import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/13kg_cylinder_screen.dart';

class ThirteenCylinderCard extends StatelessWidget {
  final String image, title, id;
  const ThirteenCylinderCard(
      {Key? key, required this.image, required this.title, required this.id})
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
                  image: AssetImage('images/14kg.jpeg'),
                )),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ThirteenCylinderScreen(
                              item: image, title: title, id: id)));
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
// import 'package:kelivog/Screens/13kg_cylinder_screen.dart';
//
// class ThirteenCylinderCard extends StatelessWidget {
//   final String image, title;
//   const ThirteenCylinderCard({Key? key, required this.image, required this.title})
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
//                           builder: (ctx) => const ThirteenCylinderScreen(item: '',)));
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
