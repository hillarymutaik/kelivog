import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Screens/six_save_delete_cylinder_details.dart';

class SixCylindersCard extends StatelessWidget {
  final String brand, price, capacityName, id, capacityId;

  const SixCylindersCard(
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
                                  item: 'images/6kg.jpeg',
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
                      height: 80.h,
                      width: 70.w,
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
                        image: AssetImage('images/6kg.jpeg'),
                      )),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('BRAND'),
                          SizedBox(
                            width: 0.2.sw,
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
                              ),)
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('CAPACITY'),
                          SizedBox(
                            width: 0.3.sw,
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
                            ),)
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowItem('AMOUNT'),
                          SizedBox(
                            width: 0.3.sw,
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
                            ),)
                          ),
                        ]),
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
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 0.2.sw, child: Text(text)),
          SizedBox(width: 5.w),
        ],
      ),
    );
  }
}
