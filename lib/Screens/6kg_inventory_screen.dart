import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Screens/save_delete_screen.dart';
import 'package:kelivog/Screens/six_save_delete_screen.dart';
import 'package:kelivog/Widget/all_six_inventory_card.dart';
import 'package:kelivog/Widget/header.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SixInventoryCylindersScreen extends StatefulWidget {
  final String item, id, title;

  const SixInventoryCylindersScreen(
      {Key? key, required this.id, required this.item, required this.title})
      : super(key: key);

  @override
  _SixInventoryPageState createState() => _SixInventoryPageState();
}

class _SixInventoryPageState extends State<SixInventoryCylindersScreen> {
  // final List<Inventory> items = [];
  late Timer timer;
  late String data;
  var allSix;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 5), (Timer t) => getInventory());

    dataLoadFunction();
  }

  dataLoadFunction() async {
    setState(() {
      isLoading = true; // your loader has started to load
    });
    // fetch you data over here
    setState(() {
      isLoading = false; // your loder will stop to finish after the data fetch
    });
  }

  void getInventory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');

    Map<String, dynamic> token = jsonDecode(jwt!);
    http.Response response = await http.get(
        Uri.parse('https://kelivog.com/inventory/withCategory/${widget.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': token['token']
        });

    if (response.statusCode == 200) {
      // Map<String, dynamic> map = json.decode(response.body);
      data = response.body;
      //store response as string
      setState(() {
        allSix = jsonDecode(data)['data'];
        //   //get all the data from json string all capacities
        if (kDebugMode) {
          print(allSix.length);
        } // Print length of data''
      });
      if (kDebugMode) {
        print(allSix[0]['brand']);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  onGoBack(dynamic value) {
    print('cylindergoing back');
    timer =
        Timer.periodic(const Duration(seconds: 5), (Timer t) => getInventory());
    setState(() {});
  }

  void inventoryData() {
    context.read<LoadingProvider>().setLoad(true);
    Route route = MaterialPageRoute(
        builder: (ctx) => SixSaveDeleteScreen(
              brand: '',
              item: widget.item,
              id: widget.id,
              title: widget.title,
              capacityId: widget.id,
              price: '',
            ));

    Navigator.push(context, route).then(onGoBack);
    context.read<LoadingProvider>().setLoad(false);
  }

  void deleteData() {
    context.read<LoadingProvider>().setLoad(true);
    Route route = MaterialPageRoute(
        builder: (ctx) => SaveDeleteScreen(
              brand: '',
              item: widget.item,
              id: widget.id,
              title: widget.title,
              capacityId: widget.id,
              price: '',
              capacity: '',
            ));

    Navigator.push(context, route).then(onGoBack);
    context.read<LoadingProvider>().setLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    print('This is the $context');
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: isLoading
            ? const CircularProgressIndicator() // this will show when loading is true
            : SingleChildScrollView(
                child: Column(
                  children: [
                    header(),
                    SizedBox(height: 5.h),

                    Text(
                      '6 Kg',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: const Color(0xff261005),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15.h),
                    ElevatedButton(
                      onPressed: inventoryData,
                      child: Text(
                        '+ ADD',
                        style: TextStyle(
                            color: const Color(0xff0ced10), fontSize: 22.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        fixedSize: Size(180.w, 50.h),
                        primary: const Color(0xff261005),
                      ),
                    ),

                    Container(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allSix == null ? 0 : allSix.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AllSixInventoryCard(
                              brand: allSix[index]['brand'],
                              capacity: allSix[index]['capacityName'],
                              price: allSix[index]['price'].toString(),
                              id: allSix[index]['_id'],
                              capacityId: widget.id,
                            );
                          },
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}
