import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:kelivog/Widget/inventory_card.dart';
import 'package:kelivog/Widget/other_cylinder_card.dart';
import 'package:kelivog/Widget/other_inventory_card.dart';
import 'package:kelivog/Widget/six_cylinder_card.dart';
import 'package:kelivog/Widget/six_inventory_card.dart';
import 'package:kelivog/Widget/thirteen_cylinder_card.dart';
import 'package:kelivog/Widget/thirteen_inventory_card.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InventoryManagerScreen extends StatefulWidget {
  const InventoryManagerScreen({Key? key}) : super(key: key);

  @override
  _InventoryManagerPageState createState() => _InventoryManagerPageState();
}

class _InventoryManagerPageState extends State<InventoryManagerScreen> {
  late String data;
  var allCapacities;

  @override
  void initState() {
    super.initState();
    getInventory();
  }

  Future<void> getInventory() async {
    http.Response response =
        await http.get(Uri.parse('https://kelivog.com/capacity'));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        allCapacities = jsonDecode(data)[
            'allCapacities']; //get all the data from json string all capacities
        if (kDebugMode) {
          print(allCapacities.length);
        } // just printed length of data
      });
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
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
              SizedBox(
                width: 0.9.sw,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        stops: const [0.01, 0.01],
                        colors: [Colors.green[800]!, Colors.grey]),
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
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SELECT CATEGORY',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: const Color(0xff261005),
                                    fontWeight: FontWeight.bold),
                          ),

                          SizedBox(height: 20.h),
                          SixInventoryCard(
                            ids: jsonDecode(data)['allCapacities'][0]['_id'],
                            image: 'images/6kg.jpeg',
                            title: jsonDecode(data)['allCapacities'][0]
                                ['capacityName'],
                          ),
                          SizedBox(height: 30.h),
                          ThirteenInventoryCard(
                            id: jsonDecode(data)['allCapacities'][1]['_id'],
                            image: 'images/14kg.jpeg',
                            title: jsonDecode(data)['allCapacities'][1]
                                ['capacityName'],
                          ),
                          //  OtherInventoryCard(
                          //    id: jsonDecode(data)['allCapacities'][2]['_id'],
                          //   image: 'images/other.jpeg',
                          //   title: jsonDecode(data)['allCapacities'][2]['capacityName'],
                          // ),

                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),
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
}
