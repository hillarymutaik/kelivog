import 'package:flutter/material.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseSuccessScreen extends StatelessWidget {
  const PurchaseSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: Column(
          children: [
            header(),
            SizedBox(height: 15.h),
            SizedBox(
              width: 0.9.sw,
              height: 0.7.sh,
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
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text(
                                'PURCHASE SUCCESSFUL',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 0.7.sw,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(child: Text('')),
                            ),
                            SizedBox(height: 40.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'PLEASE WAIT AS THE PURCHASE & CYLINDER UNDERGOES INSPECTION.\n YOU WILL RECEIVE CCOMMUNICATION ON WHERE TO PICK YOUR CYLINDER WITHIN 4 WORKIND DAYS.',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
