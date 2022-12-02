import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    required this.image,
    required this.text,
    required this.color,
    this.onTap,
  }) : super(key: key);
  final String image;
  final Text text;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              height: 40,
              width: 40,
            ),
            text,
          ],
        ),
      ),
    );
  }
}
