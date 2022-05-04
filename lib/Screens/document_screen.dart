import 'package:flutter/material.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Widget/edit_image.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
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
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Text(
                  'DOCUMENTS',
                  style:
                      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            const EditImage(
              url: "https://kelivog.com/profile/license",
              keyword: "license",
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.h),
              child: Text(
                'EPRA LICENSE',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10.h),
            Divider(
              indent: 20.w,
              endIndent: 20.w,
              thickness: 2,
            ),
            SizedBox(height: 10.h),
            const EditImage(
              url: "https://kelivog.com/profile/permit",
              keyword: "permit",
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.h),
              child: Text(
                'BUSINESS LICENSE',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 0.08.sw),
            SizedBox(height: 15..h),
            ElevatedButton(
              onPressed: () {
                context.read<LoadingProvider>().setLoad(true);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Document added'),
                  duration: Duration(seconds: 1),
                ));
                Navigator.of(context).pop();
                context.read<LoadingProvider>().setLoad(false);
              },
              child: Text(
                'UPLOAD',
                style:
                    TextStyle(color: const Color(0xff0ced10), fontSize: 18.sp),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 5,
                fixedSize: Size(130.w, 45.h),
                primary: const Color(0xff261005),
              ),
            )
          ],
        ),
      ),
    );
  }
}
