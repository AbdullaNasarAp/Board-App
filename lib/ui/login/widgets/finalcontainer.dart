import 'package:boardapp/ui/login/widgets/text1.dart';
import 'package:flutter/material.dart';

class Container1 extends StatelessWidget {
  const Container1({
    Key? key,
    required this.text1,
    required this.image,
    required this.size,
    required this.fontsize1,
    required this.fontweight1,
    required this.colors,
    required this.color1,
  }) : super(key: key);

  final Size size;
  final String image;
  final String text1;
  final Color color1;
  final double fontsize1;
  final FontWeight fontweight1;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .40,
      height: size.width * 0.26,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 40,
            width: 40,
          ),
          sizedBoxHeight(10),
          Text1(
              title: text1,
              fontsize: fontsize1,
              color: color1,
              fontweight: fontweight1)
        ],
      ),
    );
  }

  Widget sizedBoxHeight(double kHeight) {
    return SizedBox(
      height: kHeight,
    );
  }
}
