// import 'package:flutter/material.dart';
// import 'package:kelivog/Screens/save_delete_screen.dart';
// import 'package:kelivog/Widget/all_other_inventory_card.dart';
// import 'package:kelivog/Widget/all_six_inventory_card.dart';
// import 'package:kelivog/Widget/header.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kelivog/Widget/other_cylinder_card.dart';
//
// import 'package:flutter/foundation.dart';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import 'other_save_delete_screen.dart';
//
// class OtherInventoryCylindersScreen extends StatefulWidget {
//   final String item;
//
//   const OtherInventoryCylindersScreen({Key? key, required this.item})
//       : super(key: key);
//
//   @override
//   _InventoryManagerPageState createState() => _InventoryManagerPageState();
// }
//
// class _InventoryManagerPageState extends State<OtherInventoryCylindersScreen> {
//   late String data;
//   var allOthers;
//
//   @override
//   void initState() {
//     super.initState();
//     getInventory();
//   }
//
//   void getInventory() async {
//     http.Response response = await http.get(
//         Uri.parse(
//             'https://kelivog.com/inventory/withCategory/61b739ca35621b7ff70b9d8e'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           "authorization":
//               "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWZjZDZkNDMxMWM5ZGIxZGI2MjE0MmIiLCJlbWFpbCI6ImhpbGxhcnlAaG90bWFpbC5jb20iLCJpc0FkbWluIjpmYWxzZSwidG9rZW5JZCI6IjYyMDYyZTYxYjVhNDczODU3NzRmNTgyNSIsImlhdCI6MTY0NDU3MjI1N30.HU8Kolnwrtxsv6DTk6dR2lwQnlkWyaLiLdrbgj0MgO4"
//         });
//
//     if (response.statusCode == 200) {
//       data = response.body;
//       //store response as string
//       setState(() {
//         allOthers = jsonDecode(
//             data)['data']; //get all the data from json string all capacities
//         if (kDebugMode) {
//           print(allOthers.length);
//         } // Print length of data''
//       });
//
//       if (kDebugMode) {
//         print(allOthers[0]['brand']);
//       }
//     } else {
//       if (kDebugMode) {
//         print(response.statusCode);
//       }
//     }
//   }
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
//                 'Others',
//                 style: Theme.of(context).textTheme.headline5!.copyWith(
//                     color: const Color(0xff261005),
//                     fontWeight: FontWeight.bold),
//               ),
//               // Text(
//               //   item,
//               //   style: Theme.of(context).textTheme.headline5!.copyWith(
//               //       color: const Color(0xff261005),
//               //       fontWeight: FontWeight.bold),
//               // ),
//               SizedBox(height: 15.h),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (ctx) => const OtherSaveDeleteScreen()));
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
//
//               ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: allOthers == null ? 0 : allOthers.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return AllOtherInventoryCard(
//                     brand: allOthers[index]['brand'],
//                     capacity: allOthers[index]['capacityName'],
//                     price: allOthers[index]['price'].toString(),
//                     id: allOthers[index]['_id'],
//                   );
//                 },
//               ),
//
//               // SizedBox(
//               //   width: 0.85.sw,
//               //   child: ListView(
//               //     shrinkWrap: true,
//               //     physics: const ScrollPhysics(),
//               //     children: const [
//               //       AllInventoryCylindersCard(),
//               //       AllInventoryCylindersCard(),
//               //       AllInventoryCylindersCard(),
//               //       AllInventoryCylindersCard(),
//               //       AllInventoryCylindersCard(),
//               //     ],
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
