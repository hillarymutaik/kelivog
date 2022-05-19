import 'dart:async';
import 'dart:convert';
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
import '13kg_sell_details.dart';
import '6kg_cylinder_screen.dart';

class SellDetails extends StatefulWidget {
  final String item, id, title;
   SellDetails(
      {Key? key, required this.id,
        required this.item,
        required this.title,
      })
      : super(key: key);

  @override
  State<SellDetails> createState() => _SellDetailsState();
}

class _SellDetailsState extends State<SellDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<dynamic> uploadData(
      {String? brand,
      String? capacityId,
      String? cylinderId,
      String? price,
      // String? takeHome,
      required bool update,
      // String? serviceFee
      }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    Map<String, dynamic> body = {
      'brand': brand,
      'capacity': capacityId,
      'price': int.parse(price!),

      // 'serviceFee': double.parse(serviceFee!),
      // 'takeHome': double.parse(takeHome!),
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
      } else {
        print(updateCylinderRequest.body);

        Map<String, dynamic> updateResponse = {
          'message': jsonDecode(updateCylinderRequest.body)['message'],
          'success': jsonDecode(updateCylinderRequest.body)['success'],
          'data': jsonDecode(updateCylinderRequest.body)['data'],
        };
        return updateResponse;
      }
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
  TextEditingController brandController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  late final  priceController = TextEditingController();

  bool isLoading = false;

  clearTextInput() {
    brandController.clear();
    priceController.clear();
  }

  List<Inventory> inventories = [];

  Map<String, dynamic> selectedCapacity =
  {"capacity": "", "capacityId": ""} as Map<String, dynamic>;

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   takeHomecontroller.dispose();
  //   super.dispose();
  // }


  // void _printTakeHome() {
  //   setState((){
  //     var price = int.parse(priceController.text);
  //     fee = double.parse(serviceFeecontroller.text);
  //     takeH = double.parse(takeHomecontroller.text);
  //     servicefee = price * fee;
  //     takeH = price - servicefee;
  //   });
  //
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // Start listening to changes.
  //   takeHomecontroller.addListener(_printTakeHome);
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: getServiceFee(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       final details = Details.fromJson(snapshot.data);
    //       //priceController.text = finances.price ?? '';
    //       takeHomecontroller.text = (details.takeHome ?? '').toString();
    //       serviceFeecontroller.text = (details.serviceFee ?? '').toString();
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
                                  //validator: brandValidator,
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
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(width: 1.w),
                            Expanded(
                              child: Container(
                                width: 95.w,
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
                                width: 95.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: TextFormField(
                                    // onChanged: (value){
                                    //   if(value.isEmpty){
                                    //     setState(() => price = 0);
                                    //   }else{
                                    //     setState((){
                                    //       price = double.parse(value);
                                    //     });
                                    //   }
                                    // },
                                    //onChanged: (value) => price = double.parse(value),
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
                           // _calculateTakeHome;
                            context.read<LoadingProvider>().setLoad(true);
                            if (_formKey.currentState!.validate()) {
                              UploadData(
                              // update: false,
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
  // });
  }

  Widget rowItem(text, {required String details}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(text,
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

  // Future getServiceFee() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? jwt = prefs.getString('jwt');
  //   Map<String, dynamic> token = jsonDecode(jwt!);
  //   final http.Response responseFee = await http.get(Uri.parse("https://kelivog.com/serviceFee"),
  //       headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   'Authorization': token['token']
  //   });
  //     final data = jsonDecode(responseFee.body);
  //     return Future.value((data)['data']);
  // }
}

class Inventory {
  final String capacity;
  final String capacityId;

  const Inventory({
    required this.capacityId,
    required this.capacity,
  });
}

