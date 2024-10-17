import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_form_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100,
                backgroundImage: AssetImage("assets/images/logo_app.jpg"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: Dimensions.font20 * 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                      fontSize: Dimensions.font16 + Dimensions.font16 / 2,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height45),
            AppFormField(
              textController: TextEditingController(),
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: Dimensions.height20),
            AppFormField(
              textController: TextEditingController(),
              hintText: "Password",
              icon: Icons.password,
            ),
            SizedBox(height: Dimensions.height30),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "Sign into your account",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
              ],
            ),
            SizedBox(height: Dimensions.height45 * 1.5),
            Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenWidth / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: BigText(
                  text: "Sign in",
                  size: Dimensions.font20 + Dimensions.font26 / 2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.075),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.to(
                            () => const SignUpPage(),
                            transition: Transition.fade,
                          ),
                    text: "Create",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
