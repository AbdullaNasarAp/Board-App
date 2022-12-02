import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  const Field({
    Key? key,
    required this.text,
    required this.controller,
    this.keyboardType,
    required this.obscuretext,
  }) : super(key: key);

  final Widget text;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscuretext,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        label: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
