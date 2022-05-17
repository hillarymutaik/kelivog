import 'package:flutter/material.dart';
import 'package:kelivog/Screens/transaction_history_screen.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/history_item.dart';

class TransactionItemsScreen extends StatelessWidget {
  final Transaction transaction;
  final int index;
  const TransactionItemsScreen(this.transaction, this.index, {Key? key})
      : super(key: key);

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
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  child: Text(
                    'Transaction Reference No. ${index}',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: 0.9.sw,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        stops: [0.01, 0.01],
                        colors: [Colors.green, Colors.grey]),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      ),
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          image: const DecorationImage(
                            image: AssetImage("images/background.jpg"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              historyItem('TRANSACTION NO.', transaction.transactionId),
                              historyItem('CAPACITY', transaction.capacityName),
                              historyItem('DATE', transaction.date),
                              historyItem('AMOUNT', transaction.transactionAmount),
                              //historyItem('CLIENT', transaction.clientName),
                             //historyItem('TRANSACTION DESCRIPTION', transaction.id, 55),
                            ],
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
