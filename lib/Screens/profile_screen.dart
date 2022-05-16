import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Widget/green_button.dart';
import 'package:kelivog/Widget/header.dart';
import 'package:kelivog/Widget/validators.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile {
  final String? location;
  final String? idNo;
  final String? profileId;
  final String? kraNo;
  final String? contact;
  final String? businessName;
  final String? emailAddress;
  final String? ownersName;
  final String? epraLicenseNo;
  final String? businessPermit;

  const Profile(
      {this.location,
      this.profileId,
      this.idNo,
      this.kraNo,
      this.contact,
      this.businessName,
      this.emailAddress,
      this.ownersName,
      this.epraLicenseNo,
      this.businessPermit});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      location: json['location'],
      profileId: json['_id'],
      idNo: json['idNo'].toString(),
      kraNo: json['kraNo'],
      contact: json['contact'],
      businessName: json['businessName'],
      emailAddress: json['emailAddress'],
      ownersName: json['ownersName'],
      epraLicenseNo: json['epraLicenseNo'],
      businessPermit: json['businessPermit'],
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController businessNameController = new TextEditingController();
  TextEditingController emailAddressController = new TextEditingController();
  TextEditingController ownersNameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController kraController = new TextEditingController();
  TextEditingController epraController = new TextEditingController();
  TextEditingController businessLicenseController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  Future<String?> uploadProfile(
      {String? epraLicenseNo,
      String? businessPermit,
      String? kraNo,
      String? idNo,
      String? location,
      String? contact,
      String? emailAddress,
      String? ownersName,
      String? businessName,
      File? image,
      bool? profileSet}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    Map<String, dynamic> body = {
      "location": location,
      "idNo": int.parse(idNo!),
      "kraNo": kraNo,
      "contact": contact,
      "businessName": businessName,
      "emailAddress": emailAddress,
      "ownersName": ownersName,
      "epraLicenseNo": epraLicenseNo,
      "businessPermit": businessPermit
    };

    var url = Uri.parse('https://kelivog.com/users/profile');

    var request = http.MultipartRequest('POST', url);

    var stream = http.ByteStream((image!.openRead()));

    var length = await image.length();

    request.headers.addAll(
        {"Authorization": token['token'], "Content-Type": "application/json"});

    var multipartFile = await http.MultipartFile.fromPath(
        'photo', image.path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(response.statusCode);
    print(respStr);
    if (response.statusCode == 200) {
      print("SUCCESS");
      print(jsonEncode(body));
      try {
        var url = Uri.parse('https://kelivog.com/profile');
        if (profileSet != false) {
          final postRequestResponse = await http.Client().post(
            url,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token['token']
            },
            body: jsonEncode(body),
          );
          if (postRequestResponse.statusCode == 200) {
            return 'success';
          } else {
            return jsonDecode(postRequestResponse.body)['message'];
          }
        } else {
          final putRequestResponse = await http.Client().put(
            url,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token['token']
            },
            body: jsonEncode(body),
          );
          if (putRequestResponse.statusCode == 200) {
            return 'success';
          } else {
            return 'failed';
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
        context.read<LoadingProvider>().setLoad(false);
      }
    } else if (response.statusCode == 413) {
      print(response.statusCode);
      return 'image too large';
    } else {
      print(response.statusCode);
      return 'failed';
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to pick image:$e");
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to pick image:$e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadProfileScreen(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  header(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'PROFILE',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()),
                ]),
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.jpg"),
                        fit: BoxFit.cover)),
                child: Scaffold(
                    body: Center(child: Text('Error: ${snapshot.error}'))));
          } else {
            final profile = Profile.fromJson(snapshot.data);
            //final profile = json.decode(snapshot.data);

            businessNameController.text = profile.businessName ?? '';
            emailAddressController.text = profile.emailAddress ?? '';
            ownersNameController.text = profile.ownersName ?? '';
            idController.text = profile.idNo!;
            contactController.text = profile.contact ?? '';
            kraController.text = profile.kraNo ?? '';
            epraController.text = profile.epraLicenseNo ?? '';
            businessLicenseController.text = profile.businessPermit ?? '';
            locationController.text = profile.location ?? '';
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.cover)),
              child: Scaffold(
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      header(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'PROFILE',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (image == null) {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        'Choose Image',
                                        style: TextStyle(),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 20.sp,
                                          color: const Color(0xFF000000),
                                        ),
                                      )
                                    ],
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text(
                                          'Choose a profile Picture to upload',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'Camera',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        pickCamera();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Gallery',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        pickImage();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 135.h,
                              width: 1.sw,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[700],
                              ),
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 105.h,
                                width: 105.w,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xff0ced10), width: 7),
                                  color: Colors.green[700],
                                ),
                                child: image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          image!,
                                          width: 70.h,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 90.sp,
                                        color: const Color(0xff0ced10),
                                      ),
                              ),
                            ),
                            Positioned(
                                bottom: 0.h,
                                right: 120.w,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 70.w, height: 15.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Colors.green[700],
                                    ),
                                    onPressed: () {
                                      if (image != null) {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const Text(
                                                    'Choose Image',
                                                    style: TextStyle(),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 20.sp,
                                                      color: const Color(
                                                          0xFF000000),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: const <Widget>[
                                                    Text(
                                                      'Choose a profile Picture to upload',
                                                      style: TextStyle(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    pickCamera();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    pickImage();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '+EDIT',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Color(0xff0ced10),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListView(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: businessNameController,
                                validator: nameValidator,
                                cursorColor: Colors.black,
                                //showCursor: true,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: businessNameController,
                              //   validator: nameValidator,
                              //   cursorColor: Colors.black,
                              //   decoration: const InputDecoration(
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'BUSINESS NAME',
                            ),
                            const Divider(
                                indent: 15, endIndent: 15, thickness: 2),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: ownersNameController,
                                validator: nameValidator,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: ownersNameController,
                              //   validator: nameValidator,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'OWNER\'S NAME',
                            ),
                            const Divider(
                                indent: 15, endIndent: 15, thickness: 2),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: emailAddressController,
                                validator: emailValidator,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),

                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //     controller: emailAddressController,
                              //     validator: emailValidator,
                              //   cursorColor: Colors.black,
                              //   style: TextStyle(color: Colors.black, fontSize: 25.sp),
                              //   decoration: const InputDecoration(
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //     contentPadding: EdgeInsets.only(
                              //         top: 1.0, bottom: 6.0, left: 8.0),
                              //   ),
                              // ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: emailAddressController,
                              //   validator: emailValidator,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'EMAIL ADDRESS',
                            ),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: contactController,
                                validator: nameValidator,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: contactController,
                              //   validator: nameValidator,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'CONTACT',
                            ),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: locationController,
                                validator: nameValidator,
                                // controller: contactController,
                                // validator: nameValidator,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: locationController,
                              //   validator: nameValidator,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'LOCATION',
                            ),
                            const Divider(
                                indent: 15, endIndent: 15, thickness: 2),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: idController,
                                validator: nameValidator,
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: idController,
                              //   validator: nameValidator,
                              //   keyboardType: TextInputType.phone,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'I.D. NO.',
                            ),
                            const Divider(
                                indent: 15, endIndent: 15, thickness: 2),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: kraController,
                                validator: nameValidator,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: kraController,
                              //   validator: nameValidator,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'K.R.A NO.',
                            ),
                            const Divider(
                                indent: 15, endIndent: 15, thickness: 2),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: epraController,
                                validator: nameValidator,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: epraController,
                              //   validator: nameValidator,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'EPRA LICENSE NO.',
                            ),
                            const Divider(
                                indent: 15, endIndent: 15, thickness: 2),
                            profileCard(
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: businessLicenseController,
                                validator: nameValidator,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  contentPadding: EdgeInsets.only(
                                      top: 1.0, bottom: 6.0, left: 8.0),
                                ),
                              ),
                              // child: TextFormField(
                              //   textAlign: TextAlign.center,
                              //   controller: businessLicenseController,
                              //   validator: nameValidator,
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.symmetric(horizontal: 10.w),
                              //     border: InputBorder.none,
                              //     fillColor: Colors.black,
                              //   ),
                              // ),
                              title: 'BUSINESS LICENSE NO.',
                            ),
                          ],
                        ),
                      ),
                      const Divider(indent: 15, endIndent: 15, thickness: 2),
                      SizedBox(height: 20.h),
                      greenButton(
                        'SAVE',
                        () {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            //print('Saving' + businessNameController.text);
                            if (image != null) {
                              // context.read<LoadingProvider>().setLoad(true);
                              uploadProfile(
                                      image: image,
                                      businessName: businessNameController.text,
                                      ownersName: ownersNameController.text,
                                      emailAddress: emailAddressController.text,
                                      contact: contactController.text,
                                      location: locationController.text,
                                      idNo: idController.text,
                                      kraNo: kraController.text,
                                      epraLicenseNo: epraController.text,
                                      businessPermit:
                                          businessLicenseController.text,
                                      profileSet: profile.profileId != null
                                          ? false
                                          : true)
                                  .then((value) {
                                context.read<LoadingProvider>().setLoad(false);
                                value == 'success'
                                    ? {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(value!),
                                              backgroundColor: Colors.green),
                                        ),
                                        Navigator.of(context).pop(),
                                        context
                                            .read<LoadingProvider>()
                                            .setLoad(false)
                                      }
                                    : {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(value!),
                                              backgroundColor: Colors.red),
                                        ),
                                        context
                                            .read<LoadingProvider>()
                                            .setLoad(false)
                                      };
                              }).catchError((error) {
                                context.read<LoadingProvider>().setLoad(false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error.toString())));
                              });
                            } else {
                              print('no image');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('No Image'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Invalid Input'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      const Divider(indent: 15, endIndent: 15, thickness: 2),
                      SizedBox(height: 20.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "By proceeding I acknowledge that I have read Kelivog's",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Terms and Conditions  ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      const url =
                                          'https://kelivog.com/terms-and-conditions/';
                                      if (await launch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                ),
                                const TextSpan(
                                  text: ' and  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Privacy policy ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      const url =
                                          'https://kelivog.com/privacyPolicy';
                                      if (await launch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                ),
                                const TextSpan(
                                  text: ' and agree to them',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          } // snapshot.data  :- get your object which is pass from your loadProfileScreen() function
        }
      },
    );
  }

  Widget profileCard({required String title, required TextFormField child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 5.h),
            child: Text(
              title,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            width: 250.w,
            height: 55.h,
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(15)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: child,
            ),
          ),
        ),
        // const Divider(
        //   thickness: 2,
        //   indent: 50,
        //   endIndent: 50,
        // )
      ],
    );
  }

  Future loadProfileScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    var url = Uri.parse('https://kelivog.com/profile');
    final res = await http.Client().get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token['token']
      },
    );
    final data = jsonDecode(res.body);
    return Future.value((data)['data']); // return your response
  }
}
