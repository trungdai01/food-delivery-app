import 'package:flutter/material.dart';

class EmptyCartPage extends StatelessWidget {
  final String imagePath;
  final String notificationText;
  const EmptyCartPage({
    super.key,
    this.imagePath = "assets/images/empty_cart.png",
    required this.notificationText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imagePath,
          height: MediaQuery.of(context).size.height * 0.32,
          width: MediaQuery.of(context).size.width * 0.32,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          notificationText,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.0175,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
