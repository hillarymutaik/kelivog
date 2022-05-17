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
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.70,
                child: FutureBuilder(
                  future: getTransaction(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "No Data",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return createListView(context, snapshot);
                        }
                    }
                  },
                ),
              ),
              // Container(
              //     height: MediaQuery.of(context).size.height * 0.70,
              //     child: transactions.isNotEmpty
              //         ? ListView.builder(
              //             shrinkWrap: true,
              //             itemCount: transactions.length,
              //             itemBuilder: _listViewItemBuilder)
              //         : const Center(
              //             child: Text(
              //               "No Data",
              //               style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           )
              //     ),
            ],
          ),
        ),
      ),
    );
  }


  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Transaction> items = snapshot.data;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return schedulesCard(index+1);
      },
    );
  }


  Widget schedulesCard(int index) {
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
              child:  Padding(
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
                color: Colors.yellow,
              ),
              width: 0.70.sw,
              height: 65.h,
              child: Center(child: Text(transaction.transactionId)),
            ),
          ),
        ),
      )),
        ]),
      ),
    );
  }

  Widget _itemThumbnail(Transaction transaction) {
    return Text(
      transaction.id,
      style: TextStyle(fontSize: 20.0),
    );
  }

  Widget _itemTitle(Transaction transaction) {
    return Text(transaction.transactionId, style: const TextStyle(fontSize: 18.0));
  }

  Future<List<Transaction>> getTransaction() async {
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
            final Transaction transaction = Transaction(
              id: responseBody2['data']['_id'],
              transactionId: responseBody2['data']['transID'],
              clientName: responseBody2['data']['clientName'],
              capacityName: responseBody2['data']['capacityName'],
              transactionAmount: responseBody2['data']['transAmount'].toString(),
              date:responseBody2['data']['createdAt'],
            );
            print(transaction);
            transactions.add(transaction);
        }
      }
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }


}

class Transaction {
  final String transactionId;
  final String id;
  final String transactionAmount;
  final String clientName;
  final String capacityName;
  final String date;
  Transaction({
        required this.transactionAmount,
        required this.capacityName,
        required this.clientName,
        required this.date,
        required this.transactionId,
        required this.id});
}
