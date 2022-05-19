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
// import 'package:kelivog/Widget/validators.dart';
// // import 'package:kelivog/Widget/inventory_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// Future<dynamic> uploadInventory({
//   String? brand,
//   String? capacity,
//   String? price,
// }) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? jwt = prefs.getString('jwt');
//   Map<String, dynamic> token = jsonDecode(jwt!);
//   Map<String, dynamic> body = {
//     'brand': brand,
//     'capacity': capacity,
//     'price': int.parse(price!),
//   };
//   // var url = Uri.parse('https://kelivog.com/inventory/cylinder');
//   //
//   // var request = http.MultipartRequest('POST', url);
//
//   // final response = await http.post(Uri.parse('https://kelivog.com/inventory/cylinder'));
//
//   final response = await http.post(
//     Uri.parse('https://kelivog.com/inventory/cylinder'),
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': token['token']
//     },
//     body: jsonEncode(body),
//   );
//
//   // var stream = http.ByteStream((image!.openRead()));
//   //
//   // var length = await image.length();
//
//   // response.headers.addAll(
//   //     {"Authorization": token['token'],
//   //       "Content-Type": "application/json"});
//
//   // var multipartFile = await http.MultipartFile.fromPath(
//   //     'photo', image.path); //returns a Future<MultipartFile>
//   // request.files.add(multipartFile);
//   // http.StreamedResponse response = await request.send();
//   // final respStr = await response.stream.bytesToString();
//   print(response.statusCode);
//   // print(respStr);
//
//   //for getting and decoding the response into json format
//   // var responsed = await http.Response.fromStream(response);
//   // final responseData = json.decode(responsed.body);
//
//   if (response.statusCode == 200) {
//     print("SUCCESS");
//     print(jsonEncode(body));
//     final res = await http.Client().get(
//       Uri.parse('https://kelivog.com/inventory/620cc20ec6d7b38a9077d767'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': token['token']
//       },
//     );
//
//     // var res = await http.Client().post(Uri.parse(url), );
//     if (res.statusCode == 200) {
//       final data = json.decode(res.body);
//       data['data'].length == 0
//           ? await http.Client()
//               .post(
//                 Uri.parse('https://kelivog.com/inventory/cylinder'),
//                 headers: {
//                   'Content-Type': 'application/json; charset=UTF-8',
//                   'Authorization': token['token']
//                 },
//                 body: jsonEncode(body),
//               )
//               .then((value) => {
//                     if (value.statusCode == 200)
//                       {print("SUCCESS Post"), print(jsonEncode(body))}
//                     else
//                       {print("FAILED")}
//                   })
//           : await http.Client()
//               .put(
//                 Uri.parse('https://kelivog.com/inventory/cylinder'),
//                 headers: {
//                   'Content-Type': 'application/json; charset=UTF-8',
//                   'Authorization': token['token']
//                 },
//                 body: jsonEncode(body),
//               )
//               .then((value) => {
//                     if (value.statusCode == 200)
//                       {
//                         print("SUCCESS Posted"),
//                         print(jsonEncode(body)),
//                       }
//                     else
//                       {print("FAILED")}
//                   });
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
// class OtherSaveDeleteScreen extends StatefulWidget {
//   const OtherSaveDeleteScreen({Key? key}) : super(key: key);
//
//   @override
//   _SaveDeleteState createState() => _SaveDeleteState();
// }
//
// class _SaveDeleteState extends State<OtherSaveDeleteScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   File? image;
//   final brandController = TextEditingController();
//   final capacityController = TextEditingController();
//   final priceController = TextEditingController();
//
//   bool isLoading = false;
//   // bool isLoggedIN = false;
//
//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//
//       final imageTemporary = File(image.path);
//       setState(() {
//         this.image = imageTemporary;
//       });
//     } on PlatformException catch (e) {
//       // ignore: avoid_print
//       print("Failed to pick image:$e");
//     }
//   }
//
//   Future pickCamera() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);
//       if (image == null) return;
//
//       final imageTemporary = File(image.path);
//       setState(() {
//         this.image = imageTemporary;
//       });
//     } on PlatformException catch (e) {
//       // ignore: avoid_print
//       print("Failed to pick image:$e");
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
//                   image: AssetImage('images/other.jpeg'),
//                 )),
//               ),
//
//               SizedBox(height: 20.h),
//               Form(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   children: [
//                     Text("BRAND",
//                         style: TextStyle(
//                             fontSize: 20.sp, fontWeight: FontWeight.bold)),
//                     Container(
//                       height: 50.h,
//                       width: 350.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.yellow[600],
//                       ),
//                       child: TextFormField(
//                         style: TextStyle(color: Colors.black, fontSize: 20.sp),
//                         validator: brandValidator,
//                         controller: brandController,
//                         cursorColor: Colors.black,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.only(
//                               top: 1.0, bottom: 100.0, left: 8.0),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15.0)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Divider(indent: 15, endIndent: 15, thickness: 2),
//                     Text("CAPACITY",
//                         style: TextStyle(
//                             fontSize: 20.sp, fontWeight: FontWeight.bold)),
//                     Container(
//                       height: 50.h,
//                       width: 300.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.yellow[600],
//                       ),
//                       child: TextFormField(
//                         style: TextStyle(color: Colors.black, fontSize: 20.sp),
//                         // validator: nameValidator,0xff0ced10
//                         controller: capacityController,
//                         cursorColor: Colors.black,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.only(
//                               top: 1.0, bottom: 100.0, left: 8.0),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15.0)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Divider(indent: 15, endIndent: 15, thickness: 2),
//                     Text("PRICE",
//                         style: TextStyle(
//                             fontSize: 20.sp, fontWeight: FontWeight.bold)),
//                     Container(
//                       height: 50.h,
//                       width: 300.h,
//                       decoration: BoxDecoration(
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
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(indent: 15, endIndent: 15, thickness: 2),
//
//               SizedBox(height: 50.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // greenButton('SAVE', () {
//                   //   //final FormState? form = _formKey.currentState;
//                   //   if (_formKey.currentState!.validate()) {
//                   //     if (image != null) {
//                   //       uploadInventory(
//                   //           image: image,
//                   //           brand: brandController.text,
//                   //           capacity: capacityController.text,
//                   //           price: priceController.text,)
//                   //           .then((value) {
//                   //         value != 200
//                   //             ? ScaffoldMessenger.of(context).showSnackBar(
//                   //           const SnackBar(
//                   //             content: Text(
//                   //               'Error Occured',
//                   //               style: TextStyle(
//                   //                   color: Colors.white,
//                   //                   fontSize: 20,
//                   //                   fontWeight: FontWeight.bold),
//                   //             ),
//                   //             backgroundColor: Colors.red,
//                   //           ),
//                   //         )
//                   //             : ScaffoldMessenger.of(context).showSnackBar(
//                   //           const SnackBar(
//                   //             content: Text(
//                   //               'Successfully Updated',
//                   //               style: TextStyle(
//                   //                   color: Colors.white,
//                   //                   fontSize: 20,
//                   //                   fontWeight: FontWeight.bold),
//                   //             ),
//                   //             backgroundColor: Colors.green,
//                   //           ),
//                   //         );
//                   //       }).catchError((error) {
//                   //         ScaffoldMessenger.of(context).showSnackBar(
//                   //             SnackBar(content: Text(error.toString())));
//                   //       });
//                   //     } else {
//                   //       print('no image');
//                   //     }
//                   //   } else {
//                   //     print('not valid');
//                   //   }
//                   // }),
//
//                   ElevatedButton(
//                     onPressed: () async {
//                       //final FormState? form = _formKey.currentState;
//                       if (_formKey.currentState!.validate()) {
//                         if (brandController != null) {
//                           uploadInventory(
//                             //image: image,
//                             brand: brandController.text,
//                             capacity: capacityController.text,
//                             price: priceController.text,
//                           ).then((value) {
//                             value != 200
//                                 ? ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Error Occured',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       backgroundColor: Colors.red,
//                                     ),
//                                   )
//                                 : ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Successfully Updated',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       backgroundColor: Colors.green,
//                                     ),
//                                   );
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
//                   //ANOTHER POSSIBLE WAY
//                   //         final request = http.MultipartRequest(
//                   //         'POST', Uri.parse(''));
//                   //     request.fields['title'] = title.text;
//                   // request.fields['sub_title'] = subTitle.text;
//                   // request.files
//                   //     .add(await http.MultipartFile.fromPath('profile_photo', photo.path));
//                   //       request.files
//                   //           .add(await http.MultipartFile.fromPath('profile_video', video.path));
//                   // var response = await request.send();
//                   // var responseString = await response.stream.bytesToString();
//
//                   //ONPRESSED SAVE BUTTON
//                   // onPressed: () async {
//                   //   var file = await ImagePicker.pickImage(source: ImageSource.gallery);
//                   //   var res = await uploadImage(file.path, widget.url);
//                   //   setState(() {
//                   //     state = res;
//                   //     print(res);
//                   //   });
//                   // },
//
//                   // saveButton('SAVE', () async {
//                   // if (_formKey.currentState!.validate()) {
//                   // if (image != null) {
//                   //   uploadInventory(
//                   // image: image,
//                   // brand : brandController.text,
//                   // capacity: capacityController.text,
//                   // price: int.tryParse(priceController.text),
//                   //
//                   // );
//                   //   if (kDebugMode) {
//                   //     print('Inventory data saved');
//                   //   }
//                   //
//                   // } else {
//                   // if (kDebugMode) {
//                   //   print('no image');
//                   // }
//                   // }
//                   // // Navigator.pushReplacement(
//                   // //     context,
//                   // //     MaterialPageRoute(
//                   // //         builder: (context) => const SixInventoryCylindersScreen(item: '', id: '', title: '',)));
//                   // } else {
//                   // if (kDebugMode) {
//                   //   print('not valid');
//                   // }
//                   // }
//                   //             }),
//
//                   ElevatedButton(
//                     onPressed: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (ctx) => const PurchaseSuccessScreen()));
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
// // Widget saveButton(text, onTap) {
// //     return ElevatedButton(
// //       style: ElevatedButton.styleFrom(
// //         elevation: 5,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(15.r),
// //         ),
// //         fixedSize: Size(150.w, 50.h),
// //         primary: const Color(0xff261005),
// //       ),
// //         onPressed: onTap,
// //   child: Text(
// //   'SAVE',
// //   style: TextStyle(
// //     color: const Color(0xff0ced10),
// //   fontSize: 22.sp,
// //   fontWeight: FontWeight.w700,
// //   ),
// //     // ),
// //     )
// //   );
// // }
//
// }
