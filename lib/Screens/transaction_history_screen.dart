import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kelivog/Screens/transaction_items.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {

  @override
  void initState() {
    super.initState();
    getTransaction();
    scrollController.addListener(() {
      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent && !loading){
        print('New Transaction Call');
        getTransaction();
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    scrollController.dispose();
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
                child:

                // FutureBuilder(
                //   future: getTransaction(),
                //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                //     switch (snapshot.connectionState) {
                //       case ConnectionState.none:
                //       case ConnectionState.waiting:
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       default:
                //         if (snapshot.hasError) {
                //           return const Center(
                //             child: Text(
                //               "No Data",
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           );
                //         } else {
                //           return

                // FutureBuilder(
                //   future: getTransaction(),
                //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                //     switch (snapshot.connectionState) {
                //       case ConnectionState.none:
                //       case ConnectionState.waiting:
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                LayoutBuilder(
                  //future: getTransaction(),
                  builder:(context, constraints) {
                  if(transactions.isNotEmpty) {
                    return Stack(
                      children: [
                        ListView.separated(
                      controller: scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: transactions.length + (allloaded?1:0),
                      itemBuilder: (context, index) {
                        if(index<transactions.length){
                        return schedulesCard(index);
                      }else{
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: 50,
                              child: const Center(
                                child: Text("No Transactions",
                                  style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,),
                                ),
                                //child: CircularProgressIndicator(),
                              )
                          );
                        }},
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 4, color: Colors.black, indent: 15, endIndent: 15,),
                    ),
                  if(loading)...[
                    Positioned(
                     left:0,
                     bottom: 0,
                     child: SizedBox(
                       width: constraints.maxWidth,
                       height: 80,
                       child: const Center(
                       child: CircularProgressIndicator(color: Colors.blueAccent,),
                     ),)

                  ),
                   ]
                  ],
                    );
                }
                  else {
                      return const Center(
                      child: CircularProgressIndicator(),
                    );
                        // child: Text(
                        //   "No Transactions",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      // );
                  }

                },
                //         }
                //     }
                //   },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  final ScrollController scrollController = ScrollController();
  bool loading =false, allloaded=false;
  // List<String> trans=[];
  //
  // getTransactions() async{
  //
  //   if(allloaded){
  //     return;
  //   }
  //   setState(() {
  //     loading=true;
  //   });
  //
  //   await Future.delayed(Duration(microseconds: 500) );
  //   List<String> newData = transactions.length>=10?[]: List.generate(10, (index) => "${trans.length}");
  //   if(newData.isNotEmpty){
  //     trans.addAll(newData);
  //     setState(() {
  //       loading= false;
  //       allloaded=newData.isEmpty;
  //     });
  //   }
  // }




  // Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  //   List<Transaction> items = snapshot.data;
  //   return SmartRefresher(
  //    controller: refreshController,
  //    // onRefresh: () async{
  //    //   final result = await
  //    // },
  //     child:ListView.builder(
  //     shrinkWrap: true,
  //     scrollDirection: Axis.vertical,
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       return schedulesCard(index);
  //     },
  //   ));
  // }


  Widget schedulesCard(int index) {
    var transaction = transactions[index];
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        child: Row(children: [
          Text(
            '${index+ 1}. ',
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

  List<Transaction> transactions = [];

  int currentPage =5;


  Future<List<Transaction>> getTransaction() async {
    List<String> trans = [];
    if(allloaded){
      currentPage;
    }
    setState(() {
      loading=true;
    });
    await Future.delayed(const Duration(microseconds: 200) );
    List<String> newTransactions = transactions.length>=10?[]: List.generate(10, (index) => "${trans.length}");
    if(newTransactions.isNotEmpty){
      trans.addAll(newTransactions);
      setState(() {
        loading= false;
        allloaded=newTransactions.isEmpty;
      });
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    final http.Response response = await http
        .get(Uri.parse("https://kelivog.com/transactions/list?pageSize=${currentPage}&pageNo=1"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token['token']
    });
    //${transactions.length}
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
      setState(() {

      });
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

