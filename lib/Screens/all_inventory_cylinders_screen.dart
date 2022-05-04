// // import 'package:flutter/material.dart';
// // import 'package:kelivog/Screens/save_delete_screen.dart';
// // import 'package:kelivog/Widget/all_six_inventory_card.dart';
// // import 'package:kelivog/Widget/header.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// //
// //
// // class AllInventoryCylindersScreen extends StatelessWidget {
// //   final String item;
// //
// //   const AllInventoryCylindersScreen({Key? key, required this.item}) : super(key: key);
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
// //               SizedBox(height: 5.h),
// //               Text(
// //                 item,
// //                 style: Theme.of(context).textTheme.headline5!.copyWith(
// //                     color: const Color(0xff261005),
// //                     fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(height: 15.h),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (ctx) => SaveDeleteScreen()));
// //                 },
// //                 child: Text(
// //                   '+ ADD',
// //                   style: TextStyle(
// //                       color: const Color(0xff0ced10), fontSize: 22.sp),
// //                 ),
// //                 style: ElevatedButton.styleFrom(
// //                   elevation: 5,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(15.r),
// //                   ),
// //                   fixedSize: Size(180.w, 50.h),
// //                   primary: const Color(0xff261005),
// //                 ),
// //               ),
// //               SizedBox(
// //                 width: 0.85.sw,
// //                 child: ListView(
// //                   shrinkWrap: true,
// //                   physics: const ScrollPhysics(),
// //                   children: const [
// //                     AllInventoryCylindersCard(),
// //                     AllInventoryCylindersCard(),
// //                     AllInventoryCylindersCard(),
// //                     AllInventoryCylindersCard(),
// //                     AllInventoryCylindersCard(),
// //                   ],
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:convert';
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// //import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kelivog/Screens/6kg_inventory_screen.dart';
// // import 'package:kelivog/Screens/all_inventory_cylinders_screen.dart';
// // import 'package:kelivog/Screens/purchase_success_screen.dart';
// // import 'package:kelivog/Screens/save_screen.dart';
// import 'package:kelivog/Screens/withdraw_screen.dart';
// import 'package:kelivog/Widget/edit_image.dart';
// //import 'package:kelivog/Widget/edit_image.dart';
// import 'package:kelivog/Widget/green_button.dart';
// import 'package:kelivog/Widget/header.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// // import 'package:kelivog/Widget/inventory_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
//
// //import 'package:faker/faker.dart';
//
// late String data;
// var allCapacities;
// String? capacity;
//
// void getInventory() async {
//   http.Response response =
//   await http.get(Uri.parse('https://kelivog.com/capacity'));
//   if (response.statusCode == 200) {
//     data = response.body; //store response as string
//     setState(() {
//       allCapacities = jsonDecode(
//           data)['allCapacities']; //get all the data from json string all capacities
//       if (kDebugMode) {
//         print(allCapacities.length);
//       } // just printed length of data
//     });
//     var inven = jsonDecode(data)['allCapacities'][0]['capacityName'];
//     if (kDebugMode) {
//       print(inven);
//     }
//   } else {
//     if (kDebugMode) {
//       print(response.statusCode);
//     }
//   }
// }
//
//
// // class Capacity {
// //   final String capacity;
// //   //final String imageUrl;
// //
// //   const Capacity({
// //     required this.capacity,
// //    // required this.imageUrl,
// //   });
// // }
// class InvenData {
//   //static final faker = Faker();
//   static final List<Inventory> datas = List.generate(2,
//         (index) => Inventory(
//       capacity: jsonDecode(data)['allCapacities'][index]['_id'], //faker.person.name(),
//     ),
//   );
//
//   static List<Inventory> getSuggestions(String query) =>
//       List.of(datas).where((datum) {
//         final userLower = datum.capacity.toLowerCase();
//         final queryLower = query.toLowerCase();
//
//         return userLower.contains(queryLower);
//       }).toList();
// }
//
//
// Future<dynamic> uploadInventory(
//     {
//       String? brand,
//       // String? capacity,
//       String? price,
//     }) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? jwt = prefs.getString('jwt');
//   Map<String, dynamic> token = jsonDecode(jwt!);
//   Map<String, dynamic>
//
//   body = {
//     'brand': brand,
//     'capacity': capacity,
//     'price': int.parse(price!),
//   };
//   final response = await http.post(
//     Uri.parse('https://kelivog.com/inventory/cylinder'),
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': token['token']
//     },
//     body: jsonEncode(body),
//   );
//   if (kDebugMode) {
//     print(response.statusCode);
//   }
//
//   if (response.statusCode == 200) {
//     if (kDebugMode) {
//       print("SUCCESS");
//     }
//     if (kDebugMode) {
//       print(jsonEncode(body));
//     }
//     final res = await http.Client().get(
//       Uri.parse('https://kelivog.com/inventory/620cc20ec6d7b38a9077d780'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': token['token']
//       },
//     );
//     if (res.statusCode == 200) {
//       final data = json.decode(res.body);
//       data['data'].length == 0
//           ? await http.Client()
//           .post(
//         Uri.parse('https://kelivog.com/inventory/cylinder'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': token['token']
//         },
//         body: jsonEncode(body),
//       )
//           .then((value) => {
//         if (value.statusCode == 200)
//           {
//             print("SUCCESS Post"), print(jsonEncode(body))}
//         else
//           {print("FAILED")}
//       })
//           : await http.Client()
//           .put(
//         Uri.parse('https://kelivog.com/inventory/cylinder'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': token['token']
//         },
//         body: jsonEncode(body),
//       )
//           .then((value) => {
//         if (value.statusCode == 200)
//           {
//             print("SUCCESS Posted"),
//             print(jsonEncode(body)),
//           }
//         else
//           {print("FAILED")}
//       });
//
//       return res.statusCode;
//     } else {
//       print(res.statusCode);
//       throw Exception('Failed to update Inventory.' '${res.body}');
//     }
//   } else {
//     print(response.statusCode);
//     print("ERROR");
//   }
// }
//
//
//
// class Inventory {
//   final String capacity;
//
//   const Inventory({
//     required this.capacity,
//   });
//
//   static Inventory fromJson(Map<String, dynamic> json) => Inventory(
//     capacity: json['capacity'],
//   );
// }
//
// class InventoryApi {
//   static Future<List<Inventory>> getUserSuggestions(String query) async {
//     final url = Uri.parse('https://kelivog.com/capacity');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final List data = json.decode(response.body);
//       print('InventoryAPI'+response.body);
//
//       return data.map((json) => Inventory.fromJson(json)).where((cylinder) {
//         final nameLower = cylinder.capacity.toLowerCase();
//         final queryLower = query.toLowerCase();
//
//         return nameLower.contains(queryLower);
//       }).toList();
//     } else {
//       throw Exception();
//     }
//   }
// }
//
//
//
// // class InvenDet extends StatelessWidget {
// //   final Inventory inventory;
// //
// //   const InvenDet({
// //     required this.inventory,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(
// //       title: Text(inventory.capacity),
// //     ),
// //     body: ListView(
// //       children: [
// //         const Image(
// //           image: AssetImage('images/6kg.jpeg'),
// //         ),
// //         const SizedBox(height: 16),
// //         Text(
// //           inventory.capacity,
// //           style: const TextStyle(fontSize: 28),
// //           textAlign: TextAlign.center,
// //         )
// //       ],
// //     ),
// //   );
// // }
//
//
// class SixSaveDeleteScreen extends StatefulWidget {
//   const SixSaveDeleteScreen({Key? key}) : super(key: key);
//
//   @override
//   _SaveDeleteState createState() => _SaveDeleteState();
// }
//
// class _SaveDeleteState extends State<SixSaveDeleteScreen>
//     with SingleTickerProviderStateMixin {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   //File? image;
//   final brandController = TextEditingController();
//   final priceController = TextEditingController();
//   final TextEditingController capacityController = TextEditingController();
//   String? selectedCapacity;
//
//   bool isLoading = false;
//   // bool isLoggedIN = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getInventory();
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
//               SizedBox(height: 15.h),
//               //EditImage(image),
//               Container(
//                 height: 140.h,
//                 width: 150.w,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15.r),
//                   border: Border.all(color: const Color(0xff0ced10), width: 2),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black,
//                       offset: const Offset(4, 4),
//                       blurRadius: 3.r,
//                     ),
//                   ],
//                 ),
//                 child: const Center(
//                     child: Image(
//                       image: AssetImage('images/6kg.jpeg'),
//                     )
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Form(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child:
//                 Column(
//                   children: [
//                     Text("BRAND",
//                         style: TextStyle(
//                             fontSize: 20.sp, fontWeight: FontWeight.bold)),
//                     Container(
//                       height:50.h ,
//                       width: 300.h,
//                       decoration:  BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.yellow[600],
//                       ),
//                       child: TextFormField(
//                         style:
//                         TextStyle(color: Colors.black, fontSize: 20.sp),
//                         // validator: nameValidator,0xff0ced10
//                         controller: brandController,
//                         cursorColor: Colors.black,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.only(
//                               top: 1.0, bottom: 100.0, left: 8.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(15.0)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Divider(indent: 15, endIndent: 15, thickness: 2),
//                     Text("CAPACITY",
//                         style: TextStyle(
//                             fontSize: 20.sp, fontWeight: FontWeight.bold)),
//                     Container(
//                       height:50.h ,
//                       width: 300.h,
//                       decoration:  BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.yellow[600],
//                       ),
//
//                       child: TypeAheadFormField<Inventory?>(
//
//                         hideSuggestionsOnKeyboardHide: false,
//                         textFieldConfiguration: TextFieldConfiguration(
//                           controller: capacityController,
//                           cursorColor: Colors.black,
//                           decoration: const InputDecoration(
//                             // prefixIcon: Icon(Icons.search),
//                             border: OutlineInputBorder(),
//                             //hintText: 'Search Capacity',
//                           ),
//                         ),
//                         suggestionsCallback: InvenData.getSuggestions,
//                         itemBuilder: (context, Inventory? suggestion) {
//                           final inven = suggestion!;
//
//                           return ListTile(
//                             leading: Container(
//                               width: 60,
//                               height: 60,
//                               child: Image.asset(
//                                 'images/6kg.jpeg',
//                                 height: 80.h,
//                                 width: 120.w,
//                               ),
//                             ),
//                             title: Text(inven.capacity),
//                           );
//                         },
//                         noItemsFoundBuilder: (context) => const SizedBox(
//                           height: 100,
//                           child: Center(
//                             child: Text(
//                               'No Inventory Found.',
//                               style: TextStyle(fontSize: 24),
//                             ),
//                           ),
//                         ),
//
//                         onSuggestionSelected: (Inventory? suggestion) {
//                           capacityController.text = suggestion as String;
//                         },
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Capacity empty';
//                           }
//                         },
//                         onSaved: (value) => selectedCapacity = value,
//                       ),
//
//                       // onSuggestionSelected: (Inventory? suggestion) {
//                       //   final Inventory = suggestion!;
//                       //
//                       //   // Navigator.of(context).push(MaterialPageRoute(
//                       //   //   builder: (context) => const SixInventoryCylindersScreen( title: '', id: '', item: '',),
//                       //   // ));
//                       // },
//                     ),
//                     const Divider(indent: 15, endIndent: 15, thickness: 2),
//                     Text("PRICE",
//                         style: TextStyle(
//                             fontSize: 20.sp, fontWeight: FontWeight.bold)),
//                     Container(
//                       height:50.h ,
//                       width: 300.h,
//                       decoration:  BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.yellow[600],
//                       ),
//                       child: Center(
//                         child: TextFormField(
//                           //validator: amountValidator,
//                           controller: priceController,
//                           keyboardType: TextInputType.number,
//                           showCursor: false,
//                           style: const TextStyle(
//                             fontSize: 20.0,
//                             height: 2.0,
//                             color: Colors.black,
//                           ),
//                           decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(
//                                 top: 1.0, bottom: 100.0, left: 8.0),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(15.0)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),),
//               const Divider(indent: 15, endIndent: 15, thickness: 2),
//
//               SizedBox(height: 50.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: ()
//                     async {
//                       //final FormState? form = _formKey.currentState;
//                       if (_formKey.currentState!.validate()) {
//                         Scaffold.of(context).showSnackBar(SnackBar(
//                             content: Text('Capacity $selectedCapacity')
//                         ));
//                         if (brandController != null) {
//                           uploadInventory(
//                             //image: image,
//                             brand: brandController.text,
//                             //capacity: capacityController.text,
//                             price: priceController.text,)
//                               .then((value) {
//                             value != 200
//                                 ? ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'Error Occured',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 backgroundColor: Colors.red,
//                               ),
//                             )
//                                 : ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'Successfully Updated',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );
//                           }).catchError((error) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(error.toString())));
//                           });
//                         } else {
//                           print('no image');
//                         }
//                       } else {
//                         print('not valid');
//                       }
//                     },
//
//                     child: Text(
//                       'SAVE',
//                       style: TextStyle(
//                         color: Colors.lightGreenAccent,
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.r),
//                       ),
//                       fixedSize: Size(150.w, 50.h),
//                       primary: const Color(0xff261005),
//                     ),
//                   ),
//
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (ctx) => const SixSaveDeleteScreen()));
//                     },
//                     child: Text(
//                       'CLEAR',
//                       style: TextStyle(
//                         color: Colors.lightGreenAccent,
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.r),
//                       ),
//                       fixedSize: Size(150.w, 50.h),
//                       primary: const Color(0xff261005),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       // ),
//     );
//   }
//
// }
//
