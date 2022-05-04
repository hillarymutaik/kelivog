import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:kelivog/Widget/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '6kg_cylinder_screen.dart';


class Inventory {
  final String capacity;
  final String capacityId;

  const Inventory({
    required this.capacityId,
    required this.capacity,
  });
}

class SellDetails extends StatefulWidget {
  final String item, id, title;
  const SellDetails(
      {Key? key, required this.id,
        required this.item,
        required this.title})
      : super(key: key);

  @override
  State<SellDetails> createState() => _SellDetailsState();
}

class _SellDetailsState extends State<SellDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var takeHome = 0.0;
  late double price;

  var newPrice = 0.0;
  var savedAmount = 0.0;
  late double originalPrice;
  late double discount;

  void _calculateDiscount() {
    setState(() {
      savedAmount = originalPrice * discount;
      newPrice = originalPrice - (originalPrice * discount);
    });

    print(newPrice);

  }



  TextEditingController brandController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isLoading = false;

  clearTextInput() {
    brandController.clear();
    priceController.clear();
  }

  List<Inventory> inventories = [];
  List<Fee> fees = [];

  Map<String, dynamic> selectedCapacity =
      {"capacity": "", "capacityId": ""} as Map<String, dynamic>;

  Future<dynamic> UploadData(
      {String? brand,
        String? capacityId,
        String? cylinderId,
        String? price,
        required bool update}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    Map<String, dynamic> body = {
      'brand': brand,
      'capacity': capacityId,
      'price': int.parse(price!),
    };
    if (update) {
      final updateCylinderRequest = await http.Client().put(
        Uri.parse('https://kelivog.com/sell/$cylinderId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token['token']
        },
        body: jsonEncode(body),
      );

      if (updateCylinderRequest.statusCode == 200) {
        print("success");
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) =>
            const SixCylindersListsScreen(title: '', id: '', item: '',)));
      } else {
        print(updateCylinderRequest.body);

        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed"),
          backgroundColor: Colors.redAccent,
        ));
      }

      // Map<String, dynamic> updateResponse = {
      //   'message': jsonDecode(updateCylinderRequest.body)['message'],
      //   'success': jsonDecode(updateCylinderRequest.body)['success'],
      //   'data': jsonDecode(updateCylinderRequest.body)['data'],
      // };
      // return updateResponse;
    }
    final postCylinderRequest =
    await http.post(Uri.parse('https://kelivog.com/sell/cylinder'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token['token']
        },
        body: jsonEncode(body));
    Map<String, dynamic> updateResponse = {
      'message': jsonDecode(postCylinderRequest.body)['message'],
      'success': jsonDecode(postCylinderRequest.body)['success'],
      'data': jsonDecode(postCylinderRequest.body)['data'],
    };
    return updateResponse;
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
                  image: AssetImage('images/6kg.jpg'),
                )),
              ),
              SizedBox(height: 30.h),
              Form(
                key: _formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  width: 350.w,
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
                            Expanded(
                              child: Text("BRAND",
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
                                    //onChanged: (value) => brandController = double.parse(value) as TextEditingController,
                                    textAlign: TextAlign.center,
                                    controller: brandController,
                                    validator: brandValidator,
                                    cursorColor: Colors.black,
                                    //showCursor: true,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.sp),
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
                                    child: Text(widget.title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.sp))),
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
                                    //onChanged: (value) => originalPrice = double.parse(value),
                                    textAlign: TextAlign.center,
                                    controller: priceController,
                                    validator: priceValidator,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.sp),
                                    decoration: const InputDecoration(
                                      //hintText: '100',
                                      //prefix: Text("KES."),
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

                      rowItem('SERVICE FEE',fees.length.toString()),
                      rowItem('TAKE HOME',fees.toString()),

                      // rowItem('SERVICE FEE', widget.fee.toString() ),
                      // rowItem('TAKE HOME',
                      //     (priceController.toString() + widget.fee).toString()),

                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       vertical: 12.h, horizontal: 16.w),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Text("TAKE HOME",
                      //             style: TextStyle(
                      //               fontSize: 18.sp,
                      //               fontWeight: FontWeight.bold,
                      //             )),
                      //       ),
                      //       SizedBox(width: 1.w),
                      //       Expanded(
                      //         child: Container(
                      //           width: 90.w,
                      //           height: 40.h,
                      //           decoration: BoxDecoration(
                      //               color: Colors.yellow[600],
                      //               borderRadius: BorderRadius.circular(15)),
                      //           child: Center(
                      //             //child: Text(serviceFeeController.text),
                      //             child: TextFormField(
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   newPrice = originalPrice-discount;                                      });
                      //               },
                      //               showCursor: true,
                      //               cursorColor: Colors.black,
                      //               keyboardType: TextInputType.number,
                      //               textAlign: TextAlign.center,
                      //               style: const TextStyle(
                      //                 fontSize: 20.0,
                      //                 height: 2.0,
                      //                 color: Colors.black,
                      //               ),
                      //               decoration: const InputDecoration(
                      //                 contentPadding: EdgeInsets.only(
                      //                     top: 1.0, bottom: 100.0, left: 8.0),
                      //                 border: OutlineInputBorder(
                      //                   borderRadius: BorderRadius.all(
                      //                       Radius.circular(15.0)),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                            UploadData(
                              update: false,
                              brand: brandController.text,
                              capacityId: widget.id,
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
  Widget rowItem(text, String _service) {
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
          SizedBox(width: 5.w),
          Expanded(
            child: Container(
              width: 90.w,
              height: 40.h,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(child: Text('')),
            ),
          ),
        ],
      ),
    );
  }

  void getServiceFee() async {
    final http.Response responseFee =
    await http.get(Uri.parse("https://kelivog.com/serviceFee"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (responseFee.statusCode == 200) {
      var responseBody2 = json.decode(responseFee.body);
      print(responseBody2);
      for (final dynamic item in responseBody2['data']) {
        final Fee fee = Fee(
          fee: item['serviceFee'],
        );
        print(fee.fee);
        fees.add(fee);
        print(fees);
      }
    } else {
      print(responseFee.statusCode);
    }
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

class Fee {
  final String fee;
  const Fee({
    required this.fee,
  });
}