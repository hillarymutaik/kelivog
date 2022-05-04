import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kelivog/Screens/newallstage_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../Widget/other_cylinder_card.dart';
import '../Widget/six_cylinder_card.dart';
import '../Widget/thirteen_cylinder_card.dart';

class SellCylinderScreen extends StatefulWidget {
  const SellCylinderScreen({Key? key}) : super(key: key);

  @override
  State<SellCylinderScreen> createState() => _SellCylinderScreenState();
}

class _SellCylinderScreenState extends State<SellCylinderScreen> {
  late String myData;
  // ignore: prefer_typing_uninitialized_variables
  var cylindersLength;

  @override
  void initState() {
    super.initState();
    fetchCylinderDetails();
  }

  Future fetchCylinderDetails() async {
    http.Response myResponse =
        await http.get(Uri.parse('https://kelivog.com/capacity'));

    if (myResponse.statusCode == 200) {
      myData = myResponse.body;
      setState(() {
        cylindersLength = jsonDecode(myData)['allCapacities'];
        if (kDebugMode) {
          print(cylindersLength.length);
        }
      });

      var cylinders = jsonDecode(myData)['allCapacities'][0]['capacityName'];
      if (kDebugMode) {
        print(cylinders);
      }
    } else {
      if (kDebugMode) {
        print(myResponse.statusCode);
      }
    }
  }

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
              SizedBox(
                width: 0.9.sw,
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
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          Text(
                            'SELECT CATEGORY',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: const Color(0xff261005),
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20.h),

                          SizedBox(height: 40.h),
                          SixCylinderCard(
                            id: jsonDecode(myData)['allCapacities'][0]['_id'],
                            image: 'images/gas.png',
                            title: jsonDecode(myData)['allCapacities'][0]
                                ['capacityName'],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          ThirteenCylinderCard(
                            id: jsonDecode(myData)['allCapacities'][1]['_id'],
                            image: 'images/midGas.png',
                            title: jsonDecode(myData)['allCapacities'][1]
                                ['capacityName'],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 100.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NewAllStageScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "ONGOING PURCHASES",
                                    style: TextStyle(
                                        color: const Color(0xff0ced10),
                                        fontSize: 20.sp),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    fixedSize: Size(260.w, 50.h),
                                    primary: const Color(0xff261005),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}

// <<<<<<< HEAD
// }
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:kelivog/Screens/6kg_cylinder_screen.dart';
// // import 'package:kelivog/Screens/newallstage_screen.dart';
// // import 'package:kelivog/Widget/cylindercard.dart';
// // import 'package:kelivog/Widget/header.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:kelivog/Widget/other_cylinder_card.dart';
// // import 'package:kelivog/Widget/six_cylinder_card.dart';
// // import 'package:kelivog/Widget/thirteen_cylinder_card.dart';
// //
// // class SellCylinderScreen extends StatelessWidget {
// //   const SellCylinderScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: const BoxDecoration(
// //           image: DecorationImage(
// //               image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
// //       child: Scaffold(
// //         body: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               header(),
// //               SizedBox(
// //                 width: 0.9.sw,
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(
// //                         stops: const [0.01, 0.01],
// //                         colors: [Colors.green[800]!, Colors.grey]),
// //                     borderRadius: BorderRadius.all(Radius.circular(15.r)),
// //                   ),
// //                   child: Card(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(15.r)),
// //                     ),
// //                     elevation: 2,
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.all(Radius.circular(15.r)),
// //                         image: const DecorationImage(
// //                           image: AssetImage("images/background.jpg"),
// //                           fit: BoxFit.cover,
// //                           alignment: Alignment.topCenter,
// //                         ),
// //                       ),
// //                       child: Column(
// //                         children: [
// //                           // SizedBox(height: 20.h),
// //                           // Align(
// //                           //   alignment: Alignment.topLeft,
// //                           //   child: Padding(
// //                           //     padding: EdgeInsets.symmetric(horizontal: 25.w),
// //                           //     child: Text(
// //                           //       'SELLER I.D.',
// //                           //       style: Theme.of(context).textTheme.headline5,
// //                           //     ),
// //                           //   ),
// //                           // ),
// //                           // SizedBox(height: 10.h),
// //                           // Container(
// //                           //   width: 0.8.sw,
// //                           //   height: 30.h,
// //                           //   decoration: BoxDecoration(
// //                           //       color: Colors.yellow[600],
// //                           //       borderRadius: BorderRadius.circular(15)),
// //                           //   child: const Center(child: Text('')),
// //                           // ),
// //                           // SizedBox(height: 10.h),
// //                           // Align(
// //                           //   alignment: Alignment.topLeft,
// //                           //   child: Padding(
// //                           //     padding: EdgeInsets.symmetric(horizontal: 25.w),
// //                           //     child: Text(
// //                           //       'LOCATION',
// //                           //       style: Theme.of(context).textTheme.headline5,
// //                           //     ),
// //                           //   ),
// //                           // ),
// //                           // SizedBox(height: 10.h),
// //                           // Container(
// //                           //   width: 0.8.sw,
// //                           //   height: 30.h,
// //                           //   decoration: BoxDecoration(
// //                           //       color: Colors.yellow[600],
// //                           //       borderRadius: BorderRadius.circular(15)),
// //                           //   child: const Center(child: Text('')),
// //                           // ),
// //                           SizedBox(height: 30.h),
// //                           Text(
// //                             'SELECT CATEGORY',
// //                             style: Theme.of(context)
// //                                 .textTheme
// //                                 .headline5!
// //                                 .copyWith(
// //                                     color: const Color(0xff261005),
// //                                     fontWeight: FontWeight.bold),
// //                           ),
// //                           SizedBox(height: 20.h),
// //                           const SixCylinderCard(
// //                             image: 'images/gas.png',
// //                             title: '6 KG',
// //                           ),
// //                           const ThirteenCylinderCard(
// //                             image: 'images/bigGas.png',
// //                             title: '13 KG',
// //                           ),
// //                           const OtherCylinderCard(
// //                             image: 'images/midGas.png',
// //                             title: 'OTHER',
// //                           ),
// //                           SizedBox(
// //                             height: 100.h,
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                               children: [
// //                                 // Text(
// //                                 //   "STATUS :",
// //                                 //   style: TextStyle(
// //                                 //     color: const Color(0xFF000000),
// //                                 //     fontSize: 20.sp,
// //                                 //     fontWeight: FontWeight.w700,
// //                                 //   ),
// //                                 // ),
// //                                 ElevatedButton(
// //                                   onPressed: () {
// //                                     Navigator.push(
// //                                       context,
// //                                       MaterialPageRoute(
// //                                         builder: (context) =>
// //                                             const NewAllStageScreen(
// //                                           item: '',
// //                                         ),
// //                                       ),
// //                                     );
// //                                   },
// //                                   child: Text(
// //                                     "STAGE",
// //                                     style: TextStyle(
// //                                         color: const Color(0xff0ced10),
// //                                         fontSize: 20.sp),
// //                                   ),
// //                                   style: ElevatedButton.styleFrom(
// //                                     elevation: 5,
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(15.r),
// //                                     ),
// //                                     fixedSize: Size(180.w, 50.h),
// //                                     primary: const Color(0xff261005),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 50.h),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// =======
//
//
// >>>>>>> mutBranch
