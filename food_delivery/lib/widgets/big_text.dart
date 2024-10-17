import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  const BigText({
    super.key,
    this.color = const Color(0xff332d2b),
    required this.text,
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
  });

  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimensions.font20 : size,
      ),
    );
  }
}
