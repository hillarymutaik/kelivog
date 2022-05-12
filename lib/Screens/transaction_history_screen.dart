import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelivog/Screens/transaction_items.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    getTransaction();
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
            children: <Widget>[
              header(),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  child: Text(
                    'TRANSACTION HISTORY',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: transactions.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: transactions.length,
                          itemBuilder: _listViewItemBuilder)
                      : const Center(
                          child: Text(
                            "No Data",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                  // child: ListView(
                  //   scrollDirection: Axis.vertical,
                  //   children: <Widget>[

                  //   ],
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigationToNewsDetail(BuildContext context, Transaction transaction) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return NewsInfo(newsDetail);
    // }));
  }
  Widget _listViewItemBuilder(BuildContext context, int index) {
    var transaction = transactions[index];
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        child: Row(children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            TransactionItemsScreen(transaction, index + 1)));
              },
              child: item1(transaction)),
        ]),
      ),
    );
    // return ListTile(
    //     contentPadding: const EdgeInsets.all(10.0),
    //     leading: _itemThumbnail(transaction),
    //     title: _itemTitle(transaction),
    //     onTap: () {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(index.toString()),
    //       ));
    //       _navigationToNewsDetail(context, transaction);
    //     });
  }

  Widget _itemThumbnail(Transaction transaction) {
    return Text(
      transaction.id,
      style: TextStyle(fontSize: 20.0),
    );
    // return Container(
    //   constraints: const BoxConstraints.tightFor(width: 100.0),
    //   child: newsDetail.url != null
    //       ? Image.network(newsDetail.url, fit: BoxFit.contain)
    //       : null,
    // );
  }

  Widget _itemTitle(Transaction transaction) {
    return Text(transaction.transactionId, style: const TextStyle(fontSize: 18.0));
  }

  void getTransaction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    final http.Response response = await http
        .get(Uri.parse("https://kelivog.com/transactions/list"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    });

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      print(responseBody);

      for (final dynamic item in responseBody['data']) {
        final http.Response response2 = await http.get(
            Uri.parse("https://kelivog.com/transactions/${item['_id']}"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token['token']
            });


        if (response2.statusCode == 200) {
          var responseBody2 = json.decode(response2.body);
          print(responseBody2);

          // for (final dynamic item in responseBody2) {
          //   final Transaction transaction = Transaction(
          //     id: responseBody2['data']['_id'],
          //     transactionId: responseBody2['data']['transID'],
          //     date: responseBody2['data']['createdAt'].toString(),
          //     clientName: responseBody2['data']['clientName'],
          //     transactionAmount: responseBody2['data']['transAmount'],
          //   );
          //   transactions.add(transaction);
          // }

          responseBody['data'].forEach((item) {
            final Transaction transaction = Transaction(
              id: responseBody2['data']['_id'],
              transactionId: responseBody2['data']['transID'],
              clientName: responseBody2['data']['clientName'],
              transactionAmount: responseBody2['data']['transAmount'].toString(),
              date:responseBody2['data']['createdAt'],
            );
            print(transaction);
            transactions.add(transaction);
          });

        }
      }
      //setState(() {});
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Widget item1(Transaction transaction) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Card(
        color: const Color(0xff0ced10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              // border: Border(
              //   bottom: BorderSide(color: Colors.green, width: 2),
              // ),
              color: Colors.yellow,
            ),
            width: 0.75.sw,
            height: 65.h,
            child: Center(child: Text(transaction.transactionId)),
          ),
        ),
      ),
    );
  }
}

class Transaction {
  final String transactionId;
  final String id;
  final String transactionAmount;
  final String clientName;
  final String date;
  Transaction(
      {
        required this.transactionAmount,
        // required this.capacityName,
        required this.clientName,
        required this.date,
        required this.transactionId,
        required this.id});
}

//
// class Transactions {
//   final String transactionId;
//   final String id;
//   final String transactionAmount;
//   final String capacityName;
//   final String clientName;
//   final String date;
//
//   Transactions(
//       {
//         required this.transactionAmount,
//         required this.capacityName,
//         required this.clientName,
//         required this.transactionId,
//         required this.id});
// }
//
// void getTransactions(String id) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? jwt = prefs.getString('jwt');
//   Map<String, dynamic> token = jsonDecode(jwt!);
//
//   final http.Response response = await http
//       .get(Uri.parse("https://kelivog.com/transactions/${id}"), headers: {
//     'Content-Type': 'application/json; charset=UTF-8',
//     'Authorization': token['token']
//   });
//
//   if (response.statusCode == 200) {
//     var responseBody2 = json.decode(response.body);
//     print(responseBody2);

//     responseBody2['data'].forEach((item) {
//       final Transactions transactionsy = Transactions(
//         id: item['_id'],
//         transactionId: item['transID'],
//         capacityName: item['capacityName'],
//         clientName: item['clientName'],
//         transactionAmount: item['transAmount'],
//         date: item['createdAt'],
//
//       );
//       print(transactionsy);
//       transactionz.add(transactionsy);
//     });
//     setState(() {});
//   } else {
//     throw Exception('Failed to load transactions');
//   }
// }