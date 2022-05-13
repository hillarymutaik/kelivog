import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:kelivog/Widget/validators.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Finance {
  final String? mpesaNumber;
  final String? financesId;
  final String? bankName;
  final int? accountNumber;
  final String? accountName;
  final int? branchCode;
  final String? bankBranch;

  Finance({
    this.financesId,
    this.mpesaNumber,
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.branchCode,
    this.bankBranch,
  });

  factory Finance.fromJson(Map<String, dynamic> json) {
    return Finance(
      financesId: json['_id'],
      mpesaNumber: json['mpesaNumber'],
      bankName: json['bankName'],
      accountNumber: json['accountNumber'],
      accountName: json['accountName'],
      branchCode: json['branchCode'],
      bankBranch: json['bankBranch'],
    );
  }
}

class FinancialDetails extends StatefulWidget {
  const FinancialDetails({Key? key}) : super(key: key);

  @override
  State<FinancialDetails> createState() => _FinancialDetailsState();
}

class _FinancialDetailsState extends State<FinancialDetails> {

  TextEditingController mpesaController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNoController = TextEditingController();
  final branchNameController = TextEditingController();
  final branchController = TextEditingController();

  Future<String?> updateFinance({
    String? mpesaNumber,
    String? bankName,
    int? accountNumber,
    String? accountName,
    int? branchCode,
    String? bankBranch,
    bool? financesSet,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    Map<String, dynamic> body = {
      'mpesaNumber': mpesaNumber,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'branchCode': branchCode,
      'bankBranch': bankBranch,
    };

    try {
      var url = Uri.parse('https://kelivog.com/financial-details');
      if (financesSet != false) {
        final postRequestResponse = await http.Client().post(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token['token']
          },
          body: jsonEncode(body),
        );
        if (postRequestResponse.statusCode == 200) {
          return 'success';
        } else {
          return jsonDecode(postRequestResponse.body)['message'];
        }
      } else {
        final putRequestResponse = await http.Client().put(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token['token']
          },
          body: jsonEncode(body),
        );
        if (putRequestResponse.statusCode == 200) {
          return 'success';
        } else {
          return 'failed';
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
      context.read<LoadingProvider>().setLoad(false);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadFinancialDetails(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  header(),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                      child: Text(
                        'FINANCIAL DETAILS',
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()),
                ]),
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.jpg"),
                        fit: BoxFit.cover)),
                child: Scaffold(
                    body: Center(child: Text('Error: ${snapshot.error}'))));
          } else {
            final finances = Finance.fromJson(snapshot.data);
            mpesaController.text = finances.mpesaNumber ?? '';
            bankNameController.text = finances.bankName ?? '';
            accountNameController.text = finances.accountName ?? '';
            accountNoController.text =
                (finances.accountNumber ?? '').toString();
            branchNameController.text = finances.bankBranch ?? '';
            branchController.text = (finances.branchCode ?? '').toString();
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.cover)),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      header(),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 6.h),
                          child: Text(
                            'FINANCIAL DETAILS',
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      SizedBox(
                        width: 0.85.sw,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                stops: const [0.1, 0.0],
                                colors: [Colors.green[800]!, Colors.grey]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.r)),
                            ),
                            elevation: 1,
                            child: Container(
                              width: 350.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.r)),
                                image: const DecorationImage(
                                  image: AssetImage("images/background.jpg"),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey, spreadRadius: 2),
                                ],
                              ),
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 8.h),
                                        child: Text(
                                          'M-PESA DETAILS',
                                          style: TextStyle(
                                              fontSize: 19.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                    rowItem(
                                      name: 'M-PESA NUMBER',
                                      child: TextFormField(
                                        validator: phoneValidator,
                                        controller: mpesaController,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                        indent: 15,
                                        endIndent: 15,
                                        thickness: 2),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 6.h),
                                        child: Text(
                                          'BANK DETAILS',
                                          style: TextStyle(
                                              fontSize: 19.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                    rowItem(
                                      name: 'BANK NAME',
                                      child: TextFormField(
                                        validator: nameValidator,
                                        controller: bankNameController,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                    rowItem(
                                      name: 'ACCOUNT NAME',
                                      child: TextFormField(
                                        validator: nameValidator,
                                        controller: accountNameController,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                    rowItem(
                                      name: 'ACCOUNT NUMBER',
                                      child: TextFormField(
                                        validator: nameValidator,
                                        controller: accountNoController,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                    rowItem(
                                      name: 'BANK BRANCH',
                                      child: TextFormField(
                                        validator: nameValidator,
                                        controller: branchNameController,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                    rowItem(
                                      name: 'BANK & BRANCH CODE',
                                      child: TextFormField(
                                        validator: nameValidator,
                                        controller: branchController,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoadingProvider>().setLoad(true);
                          updateFinance(
                                  mpesaNumber: mpesaController.text,
                                  bankName: bankNameController.text,
                                  accountNumber:
                                      int.parse(accountNoController.text),
                                  accountName: accountNameController.text,
                                  branchCode: int.parse(branchController.text),
                                  bankBranch: branchNameController.text,
                                  financesSet: finances.financesId != null
                                      ? false
                                      : true)
                              .then((value) => {
                                    value == 'success'
                                        ? {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(value!),
                                                  backgroundColor:
                                                      Colors.green),
                                            ),
                                            Navigator.of(context).pop(),
                                            context
                                                .read<LoadingProvider>()
                                                .setLoad(false)
                                          }
                                        : {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(value!),
                                                  backgroundColor: Colors.red),
                                            ),
                                            context
                                                .read<LoadingProvider>()
                                                .setLoad(false)
                                          },
                                  });
                          context.read<LoadingProvider>().setLoad(false);
                        },
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                            color: const Color(0xff0ced10),
                            fontSize: 18.sp,
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
                ),
              ),
            );
          } // snapshot.data  :- get your object which is pass from your loadFinancialDetails() function
        }
      },
    );
  }

  rowItem({required String name, required TextFormField child}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Container(
              width: 90.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(5)),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: child,
                // child: TextField(
                //   decoration: InputDecoration(
                //  contentPadding:
                //     EdgeInsets.only(top: 1.0, bottom: 100.0, left: 8.0),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                // ),
                //     fillColor: Colors.black,
                //     hintText: s,
                //     hintStyle: TextStyle(
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future loadFinancialDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    var url = Uri.parse('https://kelivog.com/financial-details');
    final res = await http.Client().get(
      url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token['token']
      },
    );
    final data = jsonDecode(res.body);
    return Future.value((data)['data']); // return your response
  }
}
