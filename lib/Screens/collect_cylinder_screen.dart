import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Screens/active_schedules_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/validators.dart';


class CollectCylinderScreen extends StatefulWidget {
   final Schedule schedule;
  const CollectCylinderScreen(
    {Key? key,
    required this.schedule})
        : super(key: key);

    @override
    State<CollectCylinderScreen> createState() => _SixSaveDeleteCylinderDetailsState();
    }

    class _SixSaveDeleteCylinderDetailsState
    extends State<CollectCylinderScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    List<Inventory> cylinders = [];

    TextEditingController brandController = TextEditingController();
    final priceController = TextEditingController();
    final TextEditingController capacityController = TextEditingController();
    Map<String, dynamic> selectedCapacity =
    {"capacity": "", "capacityId": ""} as Map<String, dynamic>;
    var jsonResponse;
    bool isLoading = false;

    @override
    void initState() {
    super.initState();
    brandController = TextEditingController(
    text: widget.schedule.brand.isNotEmpty ? widget.schedule.brand : '');
    priceController.text = widget.schedule.amount.toString().isEmpty ? '' : widget.schedule.amount.toString();
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
              //SizedBox(height: 15.h),
              Container(
                height: 80.h,
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
                  child: widget.schedule.capacity != '6 Kg'
                      ? Image.asset(
                          'images/13kg.jpg',
                          height: 70.h,
                          width: 100.w,
                        )
                      : Image.asset(
                          'images/6kg.jpg',
                          height: 70.h,
                          width: 100.w,
                        ),
                ),
              ),
              SizedBox(height: 10.h),
              Form(
            key: _formKey,
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
                child: ListView(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                  item('BRAND', details: widget.schedule.brand),
                  item('CAPACITY', details: widget.schedule.capacity),
                  Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 12.h, horizontal: 16.w),
                  child:Column(
              children: [
              Text('PRICE',
              style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold)),
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: Container(
            width: 0.7.sw,
            height: 40.h,
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(15)),
            child: Center(child:
            TextFormField(
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
       // Divider(indent: 15.w, endIndent: 15.w, thickness: 2)
        ],
      ),
       ),
              item('CLIENT\'S PHONE NO.', details: widget.schedule.buyerContact),
              ])),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.2, 1],
                      colors: [
                        Color(0xff0ced10),
                        Colors.white,
                      ],
                    ),
                    color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:ElevatedButton(
                      onPressed: () async {
                        context.read<LoadingProvider>().setLoad(true);
                          UpdateData(
                            cylinderId: widget.schedule.id,
                            update: true,
                            capacity: widget.schedule.capacity,
                            brand: widget.schedule.brand,
                            amount: priceController.text,
                          );
                      },
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                            color: const Color(0xff000000),
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                  color: Colors.black, width: 2.5)),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(200.w, 50.h)),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                        MaterialStateProperty.all(Colors.transparent),
                      )
                  ),
                ),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.2, 1],
                      colors: [
                        Color(0xff0ced10),
                        Colors.white,
                      ],
                    ),
                    color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(
                                color: Colors.black, width: 2.5)),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(200.w, 50.h)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      context.read<LoadingProvider>().setLoad(true);
                      statusUpdate();
                      //context.read<LoadingProvider>().setLoad(false);
                    },
                    child: Text('EMPTY CYLINDER COLLECTED',
                      style: TextStyle(
                          color: const Color(0xff000000), fontSize: 21.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(text, {String? details}) {
    return Column(
      children: [
        Text(text, style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: Container(
            width: 0.7.sw,
            height: 30.h,
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(15)),
            child: Center(child: Text(details!)),
          ),
        ),
        //Divider(indent: 15.w, endIndent: 15.w, thickness: 2)
      ],
    );
  }

  Future<dynamic> UpdateData(
      {String? brand,
        String? capacity,
        String? cylinderId,
        String? amount, required bool update}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    Map<String, dynamic> body = {
      'brand': brand,
      'capacity': capacity,
      'cylinderId': cylinderId,
      'price': int.parse(amount!),
    };
    if (update) {
      final updateCylinderRequest = await http.Client().put(
        Uri.parse('https://kelivog.com/schedules/price/$cylinderId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token['token']
        },
        body: jsonEncode(body),
      );
      if (updateCylinderRequest.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Price successfully updated'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ActiveSchedulesScreen()),
            result: (Route<dynamic> route) => false);
        context.read<LoadingProvider>().setLoad(false);

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (ctx) => ActiveSchedulesScreen()));

      } else {
        print(updateCylinderRequest.body);
        context.read<LoadingProvider>().setLoad(false);
        return jsonDecode(updateCylinderRequest.body)['message'];
      }
    }
  }

  Future<dynamic> statusUpdate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    Map<String, dynamic> body = {
      "status": 6,
    };
    var url = Uri.parse('https://kelivog.com/schedules/changeStatus/${widget.schedule.id}');
    final putRequestResponse = await http.Client().put(
      url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token['token']
      },
      body: jsonEncode(body),
    );

    if (putRequestResponse.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Successfully collected empty cylinder'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ActiveSchedulesScreen()),
          result: (Route<dynamic> route) => false);
      context.read<LoadingProvider>().setLoad(false);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (ctx) => ActiveSchedulesScreen()));
      // context.read<LoadingProvider>().setLoad(false);
    } else {
      print(putRequestResponse.body);
      context.read<LoadingProvider>().setLoad(false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ActiveSchedulesScreen()),
          result: (Route<dynamic> route) => false);
      context.read<LoadingProvider>().setLoad(false);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (ctx) => ActiveSchedulesScreen()));
      return jsonDecode(putRequestResponse.body)['message'];
    }
    //return putRequestResponse.statusCode;
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


