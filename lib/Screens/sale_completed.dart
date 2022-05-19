// import 'package:flutter/material.dart';
// import 'package:kelivog/Screens/newallstage_screen.dart';
// import 'package:kelivog/Screens/purchase_success_screen.dart';
// import 'package:kelivog/Widget/header.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// // class SaleCompleted extends StatefulWidget {
// //   final String prod_fullName;
// //   final String prod_pic;
// //   final double prod_old_price;
// //   final double prod_price;
// //
// //   const SaleCompleted({Key? key, required this.prod_fullName, required this.prod_pic, required this.prod_old_price, required this.prod_price}) : super(key: key);
// //
// //   @override
// //   _ProductDetailsState createState() => _ProductDetailsState();
// // }
// // class _ProductDetailsState extends State<SaleCompleted> {
// //   late double percent;
// //   @override
// //   void initState() {
// //     percent=(widget.prod_old_price - widget.prod_price)/widget.prod_old_price*100;
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text("$percent%");
// //   }
// // }
//
// // class SaleCompleted extends StatefulWidget {
// //   SaleCompleted({Key? key,}) : super(key: key);
// //
// //   //final String title;
// //
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<SaleCompleted> {
// //   var totalprice = '0';
// //   var discount = '0';
// //   var discountprice;
// //   var saved;
// //   var priceController = TextEditingController();
// //   var discountController = TextEditingController();
// //
// //   var showTotalPrice = "";
// //   var showDiscount = "";
// //
// //   var listOfDiscounts = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     print("yolo: $listOfDiscounts");
// //   }
// //
// //   @override
// //   void dispose() {
// //     // Clean up the controller when the widget is disposed.
// //
// //     priceController.dispose();
// //     discountController.dispose();
// //     super.dispose();
// //   }
// //
// //   _calculate(totalprice, discount) {
// //     totalprice = double.parse(totalprice);
// //     discount = double.parse(discount);
// //     var cal = (discount * totalprice) / 100;
// //     discountprice = totalprice - cal;
// //     return discountprice;
// //   }
// //
// //   double _calculateAmountSaved(totalprice, discountprice) {
// //     totalprice = double.parse(totalprice);
// //     double saved = totalprice - discountprice;
// //     return saved;
// //   }
// //
// //   _savedButton(showtotalprice, showdiscount, discountprice, saved) {
// //     listOfDiscounts.add({
// //       "Price": showtotalprice,
// //       "Discount": showdiscount,
// //       "Discounted Price": discountprice,
// //       "Saved": saved,
// //     });
// //
// //     print("list $listOfDiscounts");
// //     print("list item types : ${listOfDiscounts[0]["Price"]}");
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         appBar: AppBar(
// //           //title: Text(widget.title),
// //           actions: [
// //             FlatButton(
// //               onPressed: () {
// //                 // Navigator.pushNamed(context, '/history',
// //                 //     arguments: (listOfDiscounts)  );
// //
// //                 Navigator.pushNamed(context, "/history",
// //                     arguments: listOfDiscounts);
// //               },
// //               child: Text(
// //                 'History',
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         body: Padding(
// //           padding: const EdgeInsets.all(10.0),
// //           child: SingleChildScrollView(
// //             child: Column(
// //               // mainAxisAlignment: MainAxisAlignment.center,
// //               children: <Widget>[
// //                 Material(
// //                   elevation: 10.0,
// //                   child: TextField(
// //                     controller: priceController,
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(90), //Not Working
// //                       ),
// //                       hintText: "Enter Price",
// //                       focusedBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.blue)),
// //                       enabledBorder: OutlineInputBorder(
// //                         borderSide: BorderSide(color: Colors.black),
// //                       ),
// //                     ),
// //                     // onChanged: (text) {
// //                     //   totalprice = text;
// //                     // },
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   height: 25,
// //                 ),
// //                 Material(
// //                   elevation: 10.0,
// //                   child: TextField(
// //                     controller: discountController,
// //                     keyboardType: TextInputType.number,
// //                     style: TextStyle(),
// //                     decoration: InputDecoration(
// //                         hintText: "Enter Discount",
// //                         focusedBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.blue),
// //                         ),
// //                         enabledBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.black),
// //                         )),
// //                     // onChanged: (text) {
// //                     //   print("price: controller:  ${priceController.text}");
// //                     //   discount = text;
// //                     // },
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   height: 25.0,
// //                 ),
// //                 ButtonTheme(
// //                   minWidth: 120,
// //                   height: 40,
// //                   child: RaisedButton(
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10)),
// //                     child: Text(
// //                       'Discount',
// //                       style: TextStyle(fontSize: 18),
// //                     ),
// //                     elevation: 10.0,
// //                     textColor: Colors.white,
// //                     color: Colors.purpleAccent,
// //                     onPressed: () {
// //                       print("price controller: ${priceController.text}");
// //                       showTotalPrice = priceController.text;
// //                       showDiscount = discountController.text;
// //
// //                       discountprice = _calculate(
// //                           priceController.text, discountController.text);
// //
// //                       saved = _calculateAmountSaved(
// //                           priceController.text, discountprice);
// //                       priceController.clear();
// //                       discountController.clear();
// //                       print(priceController.text);
// //                       setState(() {});
// //                     },
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 Container(
// //                   width: 370.0,
// //                   height: 180,
// //                   decoration: BoxDecoration(
// //                     border: Border.all(
// //                       width: 1,
// //                       color: Colors.black,
// //                     ),
// //                   ),
// //                   child: Column(
// //                     children: [
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Text(
// //                             "Calculations",
// //                             style: TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 25,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Column(
// //                           children: [
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   "Price: " +
// //                                       (showTotalPrice ==
// //                                           "" // Ambigious logic but working
// //                                           ? ""
// //                                           : "$showTotalPrice Rs"),
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w600,
// //                                     fontSize: 18,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   "Discount: " +
// //                                       (showDiscount == ""
// //                                           ? " "
// //                                           : "$showDiscount%"),
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w600,
// //                                     fontSize: 18,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   discountprice == null
// //                                       ? "Discounted Price: "
// //                                       : "Discounted Price: $discountprice",
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w600,
// //                                     fontSize: 18,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   saved == null
// //                                       ? "Saved: "
// //                                       : "Saved Rs: $saved",
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w600,
// //                                     fontSize: 18,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 ButtonTheme(
// //                   minWidth: 130,
// //                   height: 40,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: RaisedButton(
// //                     onPressed: () {
// //                       print("List before call: $listOfDiscounts");
// //                       _savedButton(
// //                           showTotalPrice, showDiscount, discountprice, saved);
// //                     },
// //                     color: Colors.amber,
// //                     child: Text(
// //                       'Save',
// //                       style: TextStyle(fontSize: 18),
// //                     ),
// //                     elevation: 10.0,
// //                     textColor: Colors.white,
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ),
// //         // This trailing comma makes auto-formatting nicer for build methods.
// //       ),
// //     );
// //   }
// // }
//
// class SaleCompleted extends StatefulWidget {
//   const SaleCompleted({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<SaleCompleted> {
//   var newPrice = 0.0;
//   var savedAmount = 0.0;
//   late double originalPrice;
//   late double discount;
//
//   void _calculateDiscount() {
//     setState(() {
//       savedAmount = originalPrice * discount;
//       newPrice = originalPrice - (originalPrice * discount);
//     });
//
//       print(newPrice);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Discount Calculator'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('Total price: $newPrice'),
//               const SizedBox(height: 20),
//               Text('You saved: $savedAmount'),
//               const SizedBox(height: 20),
//               TextField(
//                 decoration: const InputDecoration(
//                   hintText: '100',
//                   labelText: 'Original Price',
//                   prefix: Text("KES."),
//                 ),
//                 onChanged: (value) => originalPrice = double.parse(value),
//               ),
//               TextField(
//                 decoration: const InputDecoration(
//                   hintText: '20',
//                   labelText: 'Discount Percentage',
//                   suffix: Text("%"),
//                 ),
//                 onChanged: (value) => discount = double.parse(value) / 100,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 child: const Text('calculate'),
//                 onPressed: _calculateDiscount,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // class SaleCompleted extends StatelessWidget {
// //   final Cylinder cylinder;
// //   const SaleCompleted({Key? key, required this.cylinder}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: const BoxDecoration(
// //           image: DecorationImage(
// //               image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
// //       child: Scaffold(
// //         body: Column(
// //           children: [
// //             header(),
// //             SizedBox(height: 30.h),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                       stops: const [0.01, 0.01],
// //                       colors: [Colors.green[800]!, Colors.grey]),
// //                   borderRadius: BorderRadius.all(Radius.circular(15.r)),
// //                 ),
// //                 child: Card(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(15.r)),
// //                     ),
// //                     elevation: 2,
// //                     child: Container(
// //                       width: MediaQuery.of(context).size.width,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.all(Radius.circular(15.r)),
// //                         image: const DecorationImage(
// //                           image: AssetImage("images/background.jpg"),
// //                           fit: BoxFit.cover,
// //                           alignment: Alignment.topCenter,
// //                         ),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 10,
// //                           vertical: 20,
// //                         ),
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               height: 120,
// //                               width: 120,
// //                               child: Image.network(
// //                                 "https://kelivog.s3.af-south-1.amazonaws.com/1644323348573.photo",
// //                                 fit: BoxFit.contain,
// //                               ),
// //                               clipBehavior: Clip.antiAlias,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.white,
// //                                 borderRadius: BorderRadius.circular(15.r),
// //                                 border: Border.all(
// //                                     color: const Color(0xff0ced10), width: 2),
// //                                 boxShadow: [
// //                                   BoxShadow(
// //                                     color: Colors.black,
// //                                     offset: const Offset(4, 4),
// //                                     blurRadius: 3.r,
// //                                   ),
// //                                 ],
// //                               ),
// //                               // child: Padding(
// //                               //   padding: const EdgeInsets.all(8.0),
// //                               //   child: Container(
// //                               //     color: Colors.white,
// //                               //   ),
// //                               // ),
// //                             ),
// //                             SizedBox(height: 20.h),
// //                             rowItem('BRAND', value: cylinder.brand),
// //                             rowItem('CAPACITY', value: cylinder.capacityName),
// //                             rowItem('AMOUNT', value: cylinder.price.toString()),
// //                             SizedBox(height: 10.h),
// //                             Divider(
// //                                 indent: 15.w, endIndent: 15.w, thickness: 2),
// //                             SizedBox(height: 10.h),
// //                             // cylinder.isSold? GestureDetector(
// //                             //         onTap: () {
// //                             //           Navigator.push(
// //                             //               context,
// //                             //               MaterialPageRoute(
// //                             //                   builder: (ctx) =>
// //                             //                       const PurchaseSuccessScreen()));
// //                             //         },
// //                             //         child: Text(
// //                             //           "SALE COMPLETED",
// //                             //           style: TextStyle(
// //                             //             fontSize: 24.sp,
// //                             //             fontWeight: FontWeight.w900,
// //                             //           ),
// //                             //         ),
// //                             //       )
// //                             //     : GestureDetector(
// //                             //         onTap: () {
// //                             //           Navigator.push(
// //                             //               context,
// //                             //               MaterialPageRoute(
// //                             //                   builder: (ctx) =>
// //                             //                       const PurchaseSuccessScreen()));
// //                             //         },
// //                             //         child: Text(
// //                             //           "PENDING PURCHASE",
// //                             //           style: TextStyle(
// //                             //             fontSize: 24.sp,
// //                             //             fontWeight: FontWeight.w900,
// //                             //           ),
// //                             //         ),
// //                             //       )
// //                             // SizedBox(height: 5.h),
// //                             // Divider(
// //                             //     indent: 15.w, endIndent: 15.w, thickness: 2),
// //                             // SizedBox(height: 20.h),
// //                           ],
// //                         ),
// //                       ),
// //                     )),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget rowItem(text, {required String value}) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
// //       child: Row(
// //         //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         children: [
// //           Expanded(
// //             child: Text(
// //               text,
// //               style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// //             ),
// //           ),
// //           SizedBox(width: 5.w),
// //           Expanded(
// //             child: Container(
// //               width: 90.w,
// //               height: 25.h,
// //               decoration: BoxDecoration(
// //                   color: Colors.yellow[600],
// //                   borderRadius: BorderRadius.circular(5)),
// //               child: Center(child: Text(value)),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
