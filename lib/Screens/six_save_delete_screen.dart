import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Screens/6kg_inventory_screen.dart';
// import 'package:kelivog/Screens/all_inventory_cylinders_screen.dart';
// import 'package:kelivog/Screens/purchase_success_screen.dart';
// import 'package:kelivog/Screens/save_screen.dart';
import 'package:kelivog/Screens/withdraw_screen.dart';
import 'package:kelivog/Widget/edit_image.dart';
//import 'package:kelivog/Widget/edit_image.dart';
import 'package:kelivog/Widget/green_button.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:kelivog/Widget/validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
// import 'package:kelivog/Widget/inventory_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '6kg_cylinder_screen.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';

Future<dynamic> uploadInventory(
    {String? brand,
    String? capacityId,
    String? price,
    String? cylinderId
    }) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jwt = prefs.getString('jwt');

  Map<String, dynamic> token = jsonDecode(jwt!);
  Map<String, dynamic> body = {
    'brand': brand,
    'capacity': capacityId,
    'price': int.parse(price!),
  };
  final res = await http.Client().get(
    Uri.parse('https://kelivog.com/inventory/${cylinderId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    },
  );
  print(cylinderId);
  if (res.statusCode != 200) {
    final postRes = await http.Client().post(
      Uri.parse('https://kelivog.com/inventory/cylinder'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token['token']
      },
      body: jsonEncode(body),
    );

    Map<String, dynamic> singingResponse = {
      'message': jsonDecode(postRes.body)['message'],
      'success': jsonDecode(postRes.body)['success'],
      'token': jsonDecode(postRes.body)['token'],
    };
    print(jsonDecode(postRes.body));
    return postRes.statusCode;
  } else {
    final updateRes = await http.Client().put(
      Uri.parse('https://kelivog.com/inventory/${cylinderId}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token['token']
      },
      body: jsonEncode(body),
    );

    MaterialPageRoute(
        builder: (BuildContext context) => const SixInventoryCylindersScreen(
              item: '',
              id: '',
              title: '',
            ));
    print(jsonDecode(updateRes.body));
    return updateRes.statusCode;
  }
}

class Inventory {
  final String capacity;
  final String capacityId;

  const Inventory({
    required this.capacityId,
    required this.capacity,
  });
}

class SixSaveDeleteScreen extends StatefulWidget {
  final String item, id, title, capacityId, price, brand;
  const SixSaveDeleteScreen(
      {Key? key,
      required this.capacityId,
      required this.id,
      required this.item,
      required this.title,
      required this.price,
      required this.brand})
      : super(key: key);

  @override
  _SaveDeleteState createState() => _SaveDeleteState();
}

class _SaveDeleteState extends State<SixSaveDeleteScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Inventory> inventories = [];

  //File? image;
  TextEditingController brandController = TextEditingController();
  final priceController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  Map<String, dynamic> selectedCapacity =
      {"capacity": "", "capacityId": ""} as Map<String, dynamic>;
  var jsonResponse;
  bool isLoading = false;
  //bool isLoggedIN = false;

  clearTextInput() {
    brandController.clear();
    priceController.clear();
  }

  @override
  void initState() {
    super.initState();
    brandController = TextEditingController(
        text: widget.brand.isNotEmpty ? widget.brand : '');
    priceController.text = widget.price.isEmpty ? '' : widget.price;
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
              SizedBox(height: 15.h),
              //EditImage(image),
              Container(
                height: 140.h,
                width: 150.w,
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
                child: Center(
                    child: Image(
                  image: AssetImage(widget.item),
                )),
              ),
              SizedBox(height: 20.h),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Text("BRAND",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    Container(
                      height: 50.h,
                      width: 290.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.yellow[600],
                      ),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z]')),
                        ],
                        textAlign: TextAlign.center,
                        controller: brandController,
                        validator: brandValidator,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 25.sp),
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 1.0, bottom: 4.0, left: 8.0),
                          // contentPadding:
                          // EdgeInsets.symmetric(horizontal: 10.w),
                          border: InputBorder.none,
                          fillColor: Colors.black,
                        ),
                      ),
                      // child: TextFormField(
                      //   style: TextStyle(color: Colors.black, fontSize: 20.sp),
                      //   validator: brandValidator,
                      //   controller: brandController,
                      //   cursorColor: Colors.black,
                      //   decoration: const InputDecoration(
                      //     contentPadding: EdgeInsets.only(
                      //         top: 1.0, bottom: 50.0, left: 8.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius:
                      //       BorderRadius.all(Radius.circular(15.0)),
                      //     ),
                      //   ),
                      // ),
                    ),
                    const Divider(indent: 15, endIndent: 15, thickness: 2),
                    Text("CAPACITY",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    Container(
                      height: 50.h,
                      width: 270.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.yellow[600],
                      ),
                      child: Center(
                          child: Text(widget.title,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25.sp))),
                    ),
                    const Divider(indent: 15, endIndent: 15, thickness: 2),
                    Text("PRICE",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold)),
                    Container(
                      height: 50.h,
                      width: 270.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.yellow[600],
                      ),
                      child: Center(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: priceController,
                          validator: priceValidator,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          style:
                              TextStyle(color: Colors.black, fontSize: 25.sp),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 1.0, bottom: 4.0, left: 8.0),
                            // contentPadding:
                            // EdgeInsets.symmetric(horizontal: 10.w),
                            border: InputBorder.none,
                            fillColor: Colors.black,
                          ),
                        ),

                        // child: TextFormField(
                        //   textAlign: TextAlign.center,
                        //   controller: priceController,
                        //   validator: priceValidator,
                        //   keyboardType: TextInputType.number,
                        //   showCursor: true,
                        //   style: const TextStyle(
                        //     fontSize: 25.0,
                        //     height: 2.0,
                        //     color: Colors.black,
                        //   ),
                        //   decoration: InputDecoration(
                        //     contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 10.w),
                        //     border: const OutlineInputBorder(
                        //       borderRadius:
                        //       BorderRadius.all(Radius.circular(15.0)),
                        //     ),
                        //     //border: InputBorder.none,
                        //     //fillColor: Colors.black,
                        //   ),
                        // ),
                        //
                        // child: TextFormField(
                        //   validator: priceValidator,
                        //   controller: priceController,
                        //   keyboardType: TextInputType.number,
                        //   showCursor: false,
                        //   style: const TextStyle(
                        //     fontSize: 20.0,
                        //     height: 2.0,
                        //     color: Colors.black,
                        //   ),
                        //   decoration: const InputDecoration(
                        //     contentPadding: EdgeInsets.only(
                        //         top: 1.0, bottom: 50.0, left: 8.0),
                        //     border: OutlineInputBorder(
                        //       borderRadius:
                        //       BorderRadius.all(Radius.circular(15.0)),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(indent: 15, endIndent: 15, thickness: 2),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      context.read<LoadingProvider>().setLoad(true);
                      if (_formKey.currentState!.validate()) {
                        if (widget.id != null) {
                          uploadInventory(
                                  //image: image,
                                  brand: brandController.text,
                                  cylinderId: widget.id,
                                  price: priceController.text,
                                  capacityId: widget.capacityId
                          )
                              .then((value) async {
                            value != 200
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Error Occurred',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  )
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Inventory Saved!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                            Navigator.of(context).pop();
                            context.read<LoadingProvider>().setLoad(false);
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                            context.read<LoadingProvider>().setLoad(false);
                          });
                        } else {
                          print('no image');
                          context.read<LoadingProvider>().setLoad(false);
                        }
                      } else {
                        print('not valid');
                        context.read<LoadingProvider>().setLoad(false);
                      }
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      fixedSize: Size(150.w, 50.h),
                      primary: const Color(0xff261005),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => clearTextInput(),
                    child: Text(
                      'DELETE',
                      style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      fixedSize: Size(150.w, 50.h),
                      primary: const Color(0xff261005),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
