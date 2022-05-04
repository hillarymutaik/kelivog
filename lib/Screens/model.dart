// // TODO Implement this library.
// import 'dart:convert';
//
// List<Inventory> postFromJson(String str) =>
//     List<Inventory>.from(json.decode(str).map((x) => Inventory.fromMap(x)));
//
// class Inventory {
//
//   Inventory({
//   required this.id,
//   required this.allCapacities,
//   required this.v,
//   });
//
//   String id;
//   String allCapacities;
//   String v;
//
//   factory Inventory.fromMap(Map<String, dynamic> json) => Inventory(
//   id: json["_id"],
//     allCapacities: json["allCapacities"],
//   v: json["_v"],
//   );
//
// }
//
//
// // Future<List<Inventory>> fetchPost() async {
// //   final response =
// //   await http.get(Uri.parse('https://kelivog.com/capacity'));
// //
// //   if (response.statusCode == 200) {
// //     if (kDebugMode) {
// //       print("Response status SUCCESS!: ${response.statusCode}");
// //     }
// //     // var jsonResponse = response.body;
// //     //
// //     // SharedPreferences prefs = await SharedPreferences.getInstance();
// //     // prefs.setString('jwt', jsonResponse);
// //
// //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
// //     if (kDebugMode) {
// //       print(parsed);
// //     }
// //
// //     return parsed.map<Inventory>((json) => Inventory.fromMap(json)).toList();
// //   } else {
// //     throw Exception('Failed to load data');
// //   }
// // }
// //
// //
// // class InventoryManagerScreen extends StatefulWidget {
// //   const InventoryManagerScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<InventoryManagerScreen> {
// //   late Future<List<Inventory>> futurePost;
// //
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     futurePost = fetchPost();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Fetch Data Example',
// //       theme: ThemeData(
// //         primaryColor: Colors.lightBlueAccent,
// //       ),
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Fetch Data Example'),
// //         ),
// //         body: FutureBuilder<List<Inventory>>(
// //           future: futurePost,
// //           builder: (context, snapshot) {
// //             if (snapshot.hasData) {
// //               return ListView.builder(
// //                 itemCount: snapshot.data!.length,
// //                 itemBuilder: (_, index) => Container(
// //                   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //                   padding: const EdgeInsets.all(20.0),
// //                   decoration: BoxDecoration(
// //                     color: const Color(0xff97FFFF),
// //                     borderRadius: BorderRadius.circular(15.0),
// //                   ),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         snapshot.data![index].id,
// //                         style: const TextStyle(
// //                           color: Colors.yellow,
// //                           fontSize: 25.0,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 10),
// //                       Text(snapshot.data![index].allCapacities,
// //                         style: const TextStyle(
// //                           color: Colors.yellow,
// //                           fontSize: 25.0,
// //                           fontWeight: FontWeight.bold,
// //                         ),),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             } else {
// //               return const Center(child: CircularProgressIndicator());
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
