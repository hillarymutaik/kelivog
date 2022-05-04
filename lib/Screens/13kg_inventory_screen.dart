import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelivog/Screens/save_delete_screen.dart';
import 'package:kelivog/Screens/thirteen_save_delete_screen.dart';
import 'package:kelivog/Widget/all_six_inventory_card.dart';
import 'package:kelivog/Widget/all_thirteen_inventory_card.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/thirteen_inventory_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ThirteenInventoryCylindersScreen extends StatefulWidget {
  final String item, id, title;

  const ThirteenInventoryCylindersScreen(
      {Key? key, required this.id, required this.item, required this.title})
      : super(key: key);

  @override
  _InventoryManagerPageState createState() => _InventoryManagerPageState();
}

class _InventoryManagerPageState
    extends State<ThirteenInventoryCylindersScreen> {
  late String data;
  late Timer timer;
  var allThirteen;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 5), (Timer t) => getInventory());
    getInventory();
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
      data = response.body;
      //store response as string
      setState(() {
        allThirteen = jsonDecode(data)['data'];
        //get all the data from json string all capacities
        if (kDebugMode) {
          print(allThirteen.length);
        } // Print length of data''
      });

      if (kDebugMode) {
        print(allThirteen[0]['brand']);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  onGoBack(dynamic value) {
    print('cylindergoing back');
    getInventory();
    setState(() {});
  }

  void inventoryData() {
    Route route = MaterialPageRoute(
        builder: (ctx) => ThirteenSaveDeleteScreen(
              brand: '',
              item: widget.item,
              id: widget.id,
              title: widget.title,
              capacityId: widget.id,
              price: '',
            ));
    Navigator.push(context, route).then(onGoBack);
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
              SizedBox(height: 5.h),
              Text(
                '13 Kg',
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
                  itemCount: allThirteen == null ? 0 : allThirteen.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AllThirteenInventoryCard(
                      brand: allThirteen[index]['brand'],
                      capacity: allThirteen[index]['capacityName'],
                      price: allThirteen[index]['price'].toString(),
                      id: allThirteen[index]['_id'],
                      capacityId: '',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
