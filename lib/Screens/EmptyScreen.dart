import 'package:flutter/material.dart';


class EmptyScreen extends StatelessWidget {

  final  icon;
  final String message;
  final height;

  const EmptyScreen({Key? key, @required this.icon, required this.message, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60,color: Colors.red,),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(message, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),textAlign: TextAlign.center, ),
          )
        ],
      ),
    );
  }
}
