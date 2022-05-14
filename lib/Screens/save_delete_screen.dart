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
import 'package:kelivog/Screens/six_save_delete_screen.dart';
// import 'package:kelivog/Screens/all_inventory_cylinders_screen.dart';
// import 'package:kelivog/Screens/purchase_success_screen.dart';
// import 'package:kelivog/Screens/save_screen.dart';
import 'package:kelivog/Screens/withdraw_screen.dart';
import 'package:kelivog/Widget/edit_image.dart';
//import 'package:kelivog/Widget/edit_image.dart';
import 'package:kelivog/Widget/green_button.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kelivog/Widget/validators.dart';
import 'package:provider/provider.dart';
// import 'package:kelivog/Widget/inventory_card.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> deleteInventory(
    {String? brand,
    String? capacityId,
    String? price,
    String? cylinderId}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jwt = prefs.getString('jwt');

  Map<String, dynamic> token = jsonDecode(jwt!);

  final deleteResponse = await http.Client()
      .delete(Uri.parse('https://kelivog.com/inventory/$cylinderId'), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': token['token']
  });
  Map<String, dynamic> deleteResponseResult = {
    'message': jsonDecode(deleteResponse.body)['message'],
    'success': jsonDecode(deleteResponse.body)['success'],
  };
  return deleteResponseResult;
}

class Inventory {
  final String capacity;
  final String capacityId;

  const Inventory({
    required this.capacityId,
    required this.capacity,
  });
}

class SaveDeleteScreen extends StatefulWidget {
  final String item, brand, capacityId, price, title, id, capacity;
  const SaveDeleteScreen(
      {Key? key,
      required this.item,
      required this.brand,
      required this.capacityId,
      required this.price,
      required this.title,
      required this.id,
      required this.capacity})
      : super(key: key);

  @override
  _SaveDeleteState createState() => _SaveDeleteState();
}

class _SaveDeleteState extends State<SaveDeleteScreen>
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
              child: Column(children: [
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
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Container(
                height: 50.h,
                width: 290.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.yellow[600],
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 20.sp),
                  validator: brandValidator,
                  textAlign: TextAlign.center,
                  controller: brandController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 1.0, bottom: 5.0, left: 8.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Divider(indent: 15, endIndent: 15, thickness: 2),
              Text("CAPACITY",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Container(
                height: 50.h,
                width: 260.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.yellow[600],
                ),
                child: Center(
                    child: Text(widget.title,
                        style:
                            TextStyle(color: Colors.black, fontSize: 20.sp))),
              ),
              const Divider(indent: 15, endIndent: 15, thickness: 2),
              Text("PRICE",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Container(
                height: 50.h,
                width: 260.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.yellow[600],
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 20.sp),
                  validator: priceValidator,
                  textAlign: TextAlign.center,
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 1.0, bottom: 5.0, left: 8.0),
                    border: InputBorder.none,
                  ),
                ),

                // child: Center(
                //     child: Text(widget.price,
                //         style: TextStyle(
                //             color: Colors.black, fontSize: 20.sp))),
              ),
            ],
          ),
        ),
        const Divider(indent: 15, endIndent: 15, thickness: 2),
        SizedBox(height: 50.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () async {
              context.read<LoadingProvider>().setLoad(true);
              //final FormState? form = _formKey.currentState;
              if (_formKey.currentState!.validate()) {
                if (widget.id != null) {
                  uploadInventory(
                          //image: image,
                          brand: brandController.text,
                          cylinderId: widget.id,
                          price: priceController.text,
                          capacityId: widget.capacityId)
                      .then((value) {
                    value != 200
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Error Occured',
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
                                'Inventory cylinder updated!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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
              'UPDATE',
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
            onPressed: () async {
              context.read<LoadingProvider>().setLoad(true);
              if (_formKey.currentState!.validate()) {
                if (widget.id != null) {
                  deleteInventory(
                          //image: image,
                          brand: brandController.text,
                          cylinderId: widget.id,
                          price: priceController.text,
                          capacityId: widget.capacityId)
                      .then((value) {
                    final responseValue = value.cast<String, dynamic>();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(responseValue['message']),
                          backgroundColor: responseValue['success']
                              ? Colors.green
                              : Colors.red),
                    );
                    Navigator.of(context).pop();
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
        ])
      ]))),
    );
  }

  void getInventory() async {
    final http.Response response2 =
        await http.get(Uri.parse("https://kelivog.com/capacity"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response2.statusCode == 200) {
      var responseBody2 = json.decode(response2.body);
      print(responseBody2);
      for (final dynamic item in responseBody2['allCapacities']) {
        final Inventory inventory = Inventory(
          capacityId: item['_id'],
          capacity: item['capacityName'],
        );
        print(inventory.capacityId);
        inventories.add(inventory);
        print(inventories);
      }
    } else {
      print(response2.statusCode);
    }
  }
}
