
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BCListWidget extends StatefulWidget {
  BCListWidget({Key? key}) : super(key: key);

  @override
  _BCListWidgetState createState() => _BCListWidgetState();
}

class _BCListWidgetState extends State<BCListWidget> {

  final List<dynamic> _bcs = [
    "홍길동",
    "영수",
    "철수",
    "민규",
    "홍길동",
    "영수",
    "철수",
    "민규",
    "홍길동",
    "영수",
    "철수",
    "민규",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _bcs.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Text(_bcs[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
            	const Divider(thickness: 3),
    );
  }
}