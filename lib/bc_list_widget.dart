
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BCListWidget extends StatefulWidget {
  BCListWidget({Key? key}) : super(key: key);

  @override
  _BCListWidgetState createState() => _BCListWidgetState();
}

class _BCListWidgetState extends State<BCListWidget> {

  List<dynamic> bcs = [
    "홍길동",
    "영수",
    "철수",
    "민규",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: bcs.length,
      itemBuilder: (BuildContext context, int index) {
      return Text(bcs[index]);
      }
    );
  }
}