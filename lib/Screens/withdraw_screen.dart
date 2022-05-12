import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String _value = 'M-Pesa';
  late Future<Balance> futureBalance;
  final amountController = TextEditingController();

  var items = ['M-Pesa', 'Bank'];

  @override
  void initState() {
    super.initState();
    futureBalance = getBalance()!;
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
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  child: Text(
                    'WITHDRAW',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'RUNNING BALANCE',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: FutureBuilder<Balance>(
                    future: futureBalance,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data!.balance.toString());
                        return Text(
                          ['KES. ', snapshot.data!.balance.toString()].join(),
                          style: TextStyle(
                              color: const Color(0xff0ced10), fontSize: 16.sp),
                        );
                      } else if (snapshot.hasError) {
                        print('error ${snapshot.error}');
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  fixedSize: Size(0.65.sw, 45.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  primary: const Color(0xff261005),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'AMOUNT TO WITHDRAW',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 45.h,
                width: 240.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff261005),
                ),
                child: TextFormField(
                  style: TextStyle(
                      color: const Color(0xff0ced10), fontSize: 16.sp),
                  // validator: nameValidator,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.yellow,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    border: InputBorder.none,
                    // border: const OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    // ),
                    fillColor: Colors.black26,
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text(
              //     '',
              //     style:
              //         TextStyle(color: const Color(0xff0ced10), fontSize: 16.sp),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     elevation: 5,
              //     fixedSize: Size(0.65.sw, 45.h),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.r),
              //     ),
              //     primary: const Color(0xff261005),
              //   ),
              // ),
              SizedBox(height: 30.h),
              Text(
                'WITHDRAW To BANK OR MPESA',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),

              Container(
                height: 45.h,
                width: 240.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff261005),
                ),
                child: DropdownButton(
                  value: _value,
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Color(0xff0ced10),
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50.0, left: 30.0),
                        child: Text(
                          items,
                          style: const TextStyle(
                              color: Color(0xff0ced10),
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _value = value!;
                    });
                  },
                ),
              ),

              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text(
              //     '',
              //     style:
              //         TextStyle(color: const Color(0xff0ced10), fontSize: 16.sp),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     elevation: 5,
              //     fixedSize: Size(0.65.sw, 45.h),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.r),
              //     ),
              //     primary: const Color(0xff261005),
              //   ),
              // ),
              SizedBox(height: 60.h),
              Divider(
                thickness: 2,
                endIndent: 15.w,
                indent: 15.w,
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () {
                  context.read<LoadingProvider>().setLoad(true);
                  withdrawalRequest(amount: amountController.text, type: _value)
                      .then((value) => value == 'Successfully Withdrawn'
                          ? {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('$value'),
                                backgroundColor: Colors.green,
                              )),
                              context.read<LoadingProvider>().setLoad(false)
                            }
                          : {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('$value'),
                                backgroundColor: Colors.red,
                              )),
                              context.read<LoadingProvider>().setLoad(false)
                            })
                      .then((value) => Navigator.pop(context));
                  context.read<LoadingProvider>().setLoad(false);
                },
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                      color: const Color(0xff0ced10),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  fixedSize: Size(200.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  primary: const Color(0xff261005),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Balance>? getBalance() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jwt = prefs.getString('jwt');
  Map<String, dynamic> token = jsonDecode(jwt!);

  var url = Uri.parse('https://kelivog.com/balance');
  final res = await http.Client().get(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": token['token']
    },
  );
  if (res.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseBody = json.decode(res.body);
    print(responseBody['data'][0]);

    final Balance schedule = Balance(
      balance: responseBody['data']['balance'].toString(),
    );
    return schedule;
    // return Balance.fromJson(jsonDecode(res.body["data"]));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Balance {
  final String balance;

  const Balance({
    required this.balance,
  });

  // factory Balance.fromJson(Map<String, dynamic> json) {
  //   return Balance(
  //     balance: json['balance'].toString(),
  //   );
  // }
}

Future<dynamic> withdrawalRequest(
    {required String amount, required String type}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? jwt = prefs.getString('jwt');
  Map<String, dynamic> token = jsonDecode(jwt!);
  Map<String, Object> body = {
    'amount': int.parse(amount),
  };
  var url = Uri.parse('https://kelivog.com/withdraw');
  final res = await http.Client().post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": token['token']
    },
    body: jsonEncode(body),
  );

  // var res = await http.Client().post(Uri.parse(url), );
  if (res.statusCode == 200) {
    if (kDebugMode) {
      print("Response status: ${res.body}");
    }

    return 'Successfully Withdrawn';

    // final data = json.decode(res.body);
    // data['data'].length == 0
    //     ? await http.Client().post(
    //         url,
    //         headers: {
    //           'Content-Type': 'application/json; charset=UTF-8',
    //           'Authorization': token['token']
    //         },
    //         body: jsonEncode(body),
    //       )
    //     : await http.Client().put(
    //         url,
    //         headers: {
    //           'Content-Type': 'application/json; charset=UTF-8',
    //           'Authorization': token['token']
    //         },
    //         body: jsonEncode(body),
    //       );
  } else {
    if (kDebugMode) {
      print("Response status: ${res.body} ");
    }
    var data = json.decode(res.body);
    return data['message'];
    // throw Exception('Failed to update Finance.' '${jsonEncode(body)}');
  }
}

void setState(Null Function() param0) {}
