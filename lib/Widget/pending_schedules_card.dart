// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kelivog/Screens/accept_screen.dart';
// import '../Screens/pending_schedules_screen.dart';
//
// class PendingSchedulesCard extends StatelessWidget {
//   final Pending schedule;
//   const PendingSchedulesCard({Key? key, required this.schedule})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: SizedBox(
//         width: 0.85.sw,
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//                 stops: [0.01, 0.01], colors: [Colors.green, Colors.grey]),
//             borderRadius: BorderRadius.all(Radius.circular(15.r)),
//           ),
//           child: Card(
//             elevation: 3,
//             color: Colors.grey[200],
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.r)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (ctx) => AcceptScreen(
//                                   schedules: schedule,
//                                 )));
//                   },
//                   child: schedule.capacity != "6 Kg"
//                       ? Image.asset(
//                           'images/13kg.jpg',
//                           height: 100.h,
//                           width: 100.w,
//                         )
//                       : Image.asset(
//                           'images/6kg.jpg',
//                           height: 100.h,
//                           width: 100.w,
//                         ),
//                 ),
//                 Column(
//                   children: [
//                     rowItem('BRAND', details: schedule.brand),
//                     rowItem('CAPACITY', details: schedule.capacity),
//                     rowItem('AMOUNT', details: schedule.amount.toString()),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget rowItem(String name, {required String details}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         children: [
//           SizedBox(width: 0.2.sw, child: Text(name)),
//           SizedBox(width: 5.w),
//           SizedBox(
//             width: 0.2.sw,
//             child: Container(
//               width: 95.w,
//               height: 25.h,
//               decoration: BoxDecoration(
//                   color: Colors.yellow[600],
//                   borderRadius: BorderRadius.circular(15)),
//               child: Center(child: Text(details)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
