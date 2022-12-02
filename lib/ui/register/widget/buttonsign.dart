import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
