import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kelivog/Widget/validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Future<dynamic> UploadData(
    {String? brand, String? capacity, String? price}) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? myJWT = preferences.getString('jwt');
  Map<String, dynamic> token = jsonDecode(myJWT!);
  Map<String, dynamic> body = {
    'brand': brand,
    'capacity': capacity,
    'price': int.parse(price!),
  };

  final postResponse =
      await http.post(Uri.parse('https://kelivog.com/sell/cylinder'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token['token']
          },
          body: jsonEncode(body));
  Map<String, dynamic> updateResponse = {
    'message': jsonDecode(postResponse.body)['message'],
    'success': jsonDecode(postResponse.body)['success'],
    'data': jsonDecode(postResponse.body)['data'],
  };
  print(updateResponse);
  return updateResponse;
}

class Inventory {
  final String capacity;
  final String capacityId;

  const Inventory({
    required this.capacityId,
    required this.capacity,
  });
}

class ThirteenSellDetails extends StatefulWidget {
  final String item, id, title;

  const ThirteenSellDetails(
      {Key? key, required this.id, required this.item, required this.title})
      : super(key: key);

  @override
  State<ThirteenSellDetails> createState() => _SellDetailsState();
}

class _SellDetailsState extends State<ThirteenSellDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final brandController = TextEditingController();
  final capacityController = TextEditingController();
  final priceController = TextEditingController();

  //File? image;
  bool isLoading = false;

  clearTextInput() {
    brandController.clear();
    priceController.clear();
  }

  // _doTheMath(){
  //    //perform validation then do the math
  //    double? amount = double.tryParse(priceController.text);
  //    if(amount != null) {
  //      setState((){
  //        final serviceFee = amount * 0.05;
  //        _servicefee = serviceFee as TextEditingController;
  //        _takeHome = (amount - serviceFee) as TextEditingController;
  //      });
  //    } else {
  //      if (kDebugMode) {
  //        print('Invalid input');
  //      }
  //    }
  // }

  List<Inventory> inventories = [];
  Map<String, dynamic> selectedCapacity =
      {"capacity": "", "capacityId": ""} as Map<String, dynamic>;

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
              SizedBox(height: 20.h),
              //const EditImage(),
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
                child: const Center(
                    child: Image(
                  image: AssetImage('images/13kg.jpg'),
                )),
              ),
              SizedBox(height: 30.h),
              Form(
                key: _formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  width: 360.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    image: const DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, spreadRadius: 2),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Row(
                          children: [
                            Text("BRAND",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(width: 105.w),
                            Container(
                              width: 160.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],

                                  //onChanged: (value) => brandController = double.parse(value) as TextEditingController,
                                  textAlign: TextAlign.center,
                                  controller: brandController,
                                  validator: brandValidator,
                                  cursorColor: Colors.black,
                                  //showCursor: true,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.sp),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 1.0, bottom: 10.0, left: 8.0),
                                    // contentPadding:
                                    // EdgeInsets.symmetric(horizontal: 10.w),
                                    border: InputBorder.none,
                                    fillColor: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //const Divider(indent: 15, endIndent: 15, thickness: 2),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("CAPACITY",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(width: 1.w),
                            Expanded(
                              child: Container(
                                width: 90.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Text(widget.title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.sp))),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("PRICE",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(width: 1.w),
                            Expanded(
                              child: Container(
                                width: 90.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: priceController,
                                    validator: priceValidator,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.sp),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 1.0, bottom: 6.0, left: 8.0),
                                      // contentPadding:
                                      // EdgeInsets.symmetric(horizontal: 10.w),
                                      border: InputBorder.none,
                                      fillColor: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      context.read<LoadingProvider>().setLoad(true);
                      if (_formKey.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text('Capacity $selectedCapacity')));
                        UploadData(
                          //image: image,
                          brand: brandController.text,
                          capacity: widget.id,
                          price: priceController.text,
                        ).then((value) {
                          final responseValue = value.cast<String, dynamic>();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                responseValue['message'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: responseValue['success']
                                  ? Colors.green
                                  : Colors.red,
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

  Widget rowItem(text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Container(
              width: 98.w,
              height: 25.h,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(child: Text('')),
            ),
          ),
        ],
      ),
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
