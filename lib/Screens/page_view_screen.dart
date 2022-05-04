import 'package:flutter/material.dart';
import 'package:kelivog/Screens/account_screen.dart';
import 'package:kelivog/custom_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cylinder_screen.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'inventory_manager_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert' show ascii, base64, json, jsonDecode;

class PageViewScreen extends StatefulWidget {
  // const PageViewScreen({Key? key}) : super(key: key);
  const PageViewScreen(this.jwt, this.payload);

  factory PageViewScreen.fromBase64(String jwt) => PageViewScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

// class PageViewScreen extends StatefulWidget {
//   const PageViewScreen({Key? key}) : super(key: key);
//
//   @override
//   _PageViewScreenState createState() => _PageViewScreenState();
// }

class _PageViewScreenState extends State<PageViewScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  TabController? tabController;
  String? pic;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);

    super.initState();

    getPic();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        bottomNavigationBar: homeBottomNavigationBar(),
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            InventoryManagerScreen(),
            CylinderScreen(),
            AccountScreen(
                // pic: '',
                ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar homeBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff261005),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      iconSize: 35.sp,
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xff0ced10),
      onTap: (index) {
        setState(() {
          currentIndex = index;
          tabController!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          // icon: Icon(Icons.home),
          icon: Icon(CustomIcon.home),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomIcon.manager),
          label: 'REFILLS',
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomIcon.cylinder),
          label: 'CYLINDER',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'ACCOUNT',
        ),
      ],
    );
  }

  void getPic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jwt = prefs.getString('jwt');
    Map<String, dynamic> token = jsonDecode(jwt!);
    var url = Uri.parse('https://kelivog.com/users/profile');
    final res = await http.Client().get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token['token']
        //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWZjZDZiY2JjNTRiNjUwNTcwZTdlZGEiLCJlbWFpbCI6Imtlbm5lZHlfbXdhbmdpQGhvdG1haWwuY29tIiwiaXNBZG1pbiI6ZmFsc2UsInRva2VuSWQiOiI2MjAxMWVkYTNiZWZhZWRlODVjMGEwOTUiLCJpYXQiOjE2NDQyNDA2MDJ9.spQuGb5qtcaOqI3zjAChdkwmjwjWPliqWH4fBHmAN_0'
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      print(data['data']['linkUrl']);
      prefs.setString('pic', data['data']['linkUrl']);
    } else {
      print(res.statusCode);
    }
    //prefs.setString('profilePic', value)
    //return Future.value((data)[]);
  }
}
