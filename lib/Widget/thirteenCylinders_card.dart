import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Screens/six_save_delete_cylinder_details.dart';
//import '../Screens/13_save_delete_cylinder_details.dart';

class ThirteenCylindersCard extends StatelessWidget {
  final String brand, capacityName, id, price, capacityId;
  const ThirteenCylindersCard(
      {Key? key,
      required this.id,
      required this.price,
      required this.capacityId,
      required this.brand,
      required this.capacityName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        width: 0.85.sw,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                stops: [0.01, 0.01], colors: [Colors.green, Colors.grey]),
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          child: Card(
            elevation: 3,
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => SixSaveDeleteCylinderDetails(
                                  item: 'images/14kg.jpeg',
                                  id: id,
                                  title: capacityName,
                                  price: price,
                                  brand: brand,
                                  capacityId: capacityId,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                            color: const Color(0xff0ced10), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: const Offset(4, 4),
                            blurRadius: 3.r,
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Image(
                        image: AssetImage('images/14kg.jpeg'),
                      )),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 0.02.sw,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('BRAND'),
                          SizedBox(
                              width: 0.6.sw,
                              child: Container(
                                width: 95.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    brand,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                        ]),
                    SizedBox(
                      height: 0.02.sw,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('CAPACITY'),
                          SizedBox(
                              width: 0.6.sw,
                              child: Container(
                                width: 90.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    capacityName,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                        ]),
                    SizedBox(
                      height: 0.02.sw,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('AMOUNT'),
                          SizedBox(
                              width: 0.6.sw,
                              child: Container(
                                width: 90.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[600],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    price,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                        ]),
                    SizedBox(
                      height: 0.02.sw,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowItem(text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 0.2.sw, child: Text(text)),
          // SizedBox(width: 5.w),
        ],
      ),
    );
  }
}
