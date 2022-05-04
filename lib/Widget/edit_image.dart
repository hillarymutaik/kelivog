import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditImage extends StatefulWidget {
  final String url;
  final String keyword;
  const EditImage({
    Key? key,
    required this.url,
    required this.keyword,
  }) : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      uploadImage(imageTemporary);
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.15.sw),

      child: GestureDetector(
        onTap: () {
          if (image == null) {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        child: SizedBox(
          width: 190.w,
          height: 125.h,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 5,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: 70.w, height: 15.h),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.green[700],
                    ),
                    onPressed: () {
                      if (image != null) {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
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
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '+EDIT',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff0ced10),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 125.h,
                width: 125.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: const Color(0xff0ced10), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(4, 4),
                      blurRadius: 3.r,
                    ),
                  ],
                ),
                child: image != null
                    ? Container(
                        height: 125.h,
                        width: 125.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Image.file(
                          image!,
                          width: 125.h,
                          height: 125.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 125.h,
                        width: 125.w,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
    /*  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 125.h,
          width: 135.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: const Color(0xff0ced10), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(4, 4),
                blurRadius: 3.r,
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 70.w, height: 15.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.green[700],
            ),
            onPressed: () {},
            child: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '+EDIT',
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Color(0xff0ced10), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );*/
  }

  void uploadImage(File imageTemporary) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);

    var request = http.MultipartRequest('POST', Uri.parse(widget.url));

    var stream = http.ByteStream((imageTemporary.openRead()));

    var length = await imageTemporary.length();

    request.headers.addAll(
        {"Authorization": token['token'], "Content-Type": "application/json"});

    var multipartFile = await http.MultipartFile.fromPath(
        widget.keyword, imageTemporary.path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(response.statusCode);
    print(respStr);
  }
}
