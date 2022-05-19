// import 'package:flutter/material.dart';
// import 'package:kelivog/Screens/save_delete_screen.dart';
// import 'package:kelivog/Screens/sell_details.dart';
// import 'package:kelivog/Screens/upload_screen.dart';
// import 'package:kelivog/Widget/cylinders_lists_card.dart';
// import 'package:kelivog/Widget/header.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kelivog/Widget/schedules_card.dart';
//
// class OtherCylinderScreen extends StatelessWidget {
//   final String item;
//
//   const OtherCylinderScreen({Key? key, required this.item}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               header(),
//               SizedBox(height: 5.h),
//               Text(
//                 'OTHER',
//                 style: Theme.of(context).textTheme.headline5!.copyWith(
//                     color: const Color(0xff261005),
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 15.h),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (ctx) => const UploadScreen()));
//                 },
//                 child: Text(
//                   '+ ADD',
//                   style: TextStyle(
//                       color: const Color(0xff0ced10), fontSize: 22.sp),
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
//               SizedBox(
//                 width: 0.85.sw,
//                 child: ListView(
//                   shrinkWrap: true,
//                   physics: const ScrollPhysics(),
//                   children: const [
//                     CylindersListsCard(),
//                     CylindersListsCard(),
//                     CylindersListsCard(),
//                     CylindersListsCard(),
//                     CylindersListsCard(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
