import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  const Textfield({Key? key, required this.controller, required this.strig})
      : super(key: key);

  final TextEditingController controller;
  final String strig;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
      autocorrect: true,
      autofocus: true,
      decoration: InputDecoration(
        labelText: strig,
      ),
      controller: controller,
    ));
  }
}
