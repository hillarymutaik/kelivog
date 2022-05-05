import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kelivog/Widget/validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    Map<String, dynamic> updateResponse = {
      'message': jsonDecode(updateCylinderRequest.body)['message'],
      'success': jsonDecode(updateCylinderRequest.body)['success'],
      'data': jsonDecode(updateCylinderRequest.body)['data'],
    };
    return updateResponse;
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

Future<dynamic> deleteCylinder({String? cylinderId}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jwt = prefs.getString('jwt');

  Map<String, dynamic> token = jsonDecode(jwt!);

  final deleteResponse = await http.Client().delete(
    Uri.parse('https://kelivog.com/sell/${cylinderId}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    },
  );
  Map<String, dynamic> deleteCylinderResponse = {
    'message': jsonDecode(deleteResponse.body)['message'],
    'success': jsonDecode(deleteResponse.body)['success'],
    'token': jsonDecode(deleteResponse.body)['data'],
  };
  print(jsonDecode(deleteResponse.body));
  return deleteCylinderResponse;
}

class Inventory {
  final String capacity;
  final String capacityId;

  const Inventory({
    required this.capacityId,
    required this.capacity,
  });
}

class SixSaveDeleteCylinderDetails extends StatefulWidget {
  final String item, id, title, capacityId, price, brand;
  const SixSaveDeleteCylinderDetails(
      {Key? key,
      required this.capacityId,
      required this.id,
      required this.item,
      required this.title,
      required this.price,
      required this.brand})
      : super(key: key);

  @override
  State<SixSaveDeleteCylinderDetails> createState() =>
      _SixSaveDeleteCylinderDetailsState();
}

class _SixSaveDeleteCylinderDetailsState
    extends State<SixSaveDeleteCylinderDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Inventory> cylinders = [];

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
          child: Column(
            children: [
              header(),
              SizedBox(height: 20.h),
              //const EditImage(),

              Container(
                height: 140.h,
                width: 160.w,
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
                                width: 95.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: TextFormField(
                                    validator: brandValidator,
                                    textAlign: TextAlign.center,
                                    controller: brandController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.sp),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 1.0, bottom: 10.0, left: 8.0),
                                      border: InputBorder.none,
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
                                    validator: priceValidator,
                                    controller: priceController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.sp),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 1.0, bottom: 10.0, left: 8.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      context.read<LoadingProvider>().setLoad(true);
                      if (_formKey.currentState!.validate()) {
                        UploadData(
                          cylinderId: widget.id,
                          update: true,
                          capacityId: widget.capacityId,
                          brand: brandController.text,
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
                          print(error);
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
                      'UPDATE',
                      style: TextStyle(
                        color: const Color(0xff0ced10),
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
                        deleteCylinder(cylinderId: widget.id).then((value) {
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
                      'DELETE',
                      style: TextStyle(
                        color: const Color(0xff0ced10),
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
        )));
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
        cylinders.add(inventory);
        print(cylinders);
      }
    } else {
      print(response2.statusCode);
    }
  }
}
