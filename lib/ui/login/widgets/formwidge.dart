import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {Key? key,
      required this.hinttext,
      required this.controllerr,
      required this.true1})
      : super(key: key);
  final String hinttext;
  final TextEditingController controllerr;
  final bool true1;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true1,
      controller: controllerr,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: hinttext,
          fillColor: Colors.black),
    );
  }
}
