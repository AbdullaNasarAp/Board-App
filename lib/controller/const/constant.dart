import 'package:flutter/material.dart';

const Color kRed = Colors.red;
const Color kBlack = Colors.black;

class KSizedBox extends StatelessWidget {
  const KSizedBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width * 0.40,
        child: const Divider(
          color: Colors.grey,
        ));
  }
}
