import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kelivog/Widget/green_button.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Widget/validators.dart';

class AddCylindersScreen extends StatefulWidget {
  const AddCylindersScreen({Key? key}) : super(key: key);

  @override
  State<AddCylindersScreen> createState() => _AddCylindersScreenState();
}

class _AddCylindersScreenState extends State<AddCylindersScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final brandController = TextEditingController();
  final capacityController = TextEditingController();
  final priceController = TextEditingController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                header(),
                SizedBox(height: 15.h),
                SvgPicture.asset(
                  'images/midGas.svg',
                  width: 100.w,
                  height: 100.h,
                ),
                SizedBox(height: 25.h),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("BRAND",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: 0.9.sw,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      validator: brandValidator,
                      controller: brandController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(indent: 15.w, endIndent: 15.w, thickness: 2),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("CAPACITY",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: 0.7.sw,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      validator: nameValidator,
                      controller: capacityController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(indent: 15.w, endIndent: 15.w, thickness: 2),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("PRICE",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: 0.7.sw,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      validator: nameValidator,
                      controller: priceController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(indent: 15.w, endIndent: 15.w, thickness: 2),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("BUYER'S NAME",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: 0.7.sw,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      validator: nameValidator,
                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(indent: 15.w, endIndent: 15.w, thickness: 2),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
                    child: Text("BUYER'S CONTACT",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: 0.7.sw,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      validator: nameValidator,
                      controller: contactController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(indent: 15.w, endIndent: 15.w, thickness: 2),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: greenButton('ACCEPT', () {
                      final FormState? form = _formKey.currentState;
                      if (form!.validate()) {
                        Navigator.pop(context);
                      }
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
