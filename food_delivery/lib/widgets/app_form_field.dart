import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
//   bool isPasswordField;

  AppFormField({
    super.key,
    required this.textController,
    required this.hintText,
    required this.icon,
    // this.isPasswordField = false,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(1, 5),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        controller: widget.textController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.mainColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
