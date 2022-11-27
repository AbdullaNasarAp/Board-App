import 'package:flutter/material.dart';

class Text1 extends StatelessWidget {
  const Text1(
      {Key? key,
      required this.title,
      required this.fontsize,
      required this.color,
      required this.fontweight})
      : super(key: key);
  final String title;
  final double fontsize;
  final Color color;
  final FontWeight fontweight;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(fontSize: fontsize, fontWeight: fontweight, color: color),
    );
  }
}
