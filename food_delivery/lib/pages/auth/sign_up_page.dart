import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_snack_bar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_form_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneNumberController = TextEditingController();
    var nameController = TextEditingController();
    var signUpMethodImages = [
      "tiktok.png",
      "facebook.png",
      "google.png",
    ];

    void earlyCheckRegistration() {
      var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneNumberController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Email is blank!", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Email is invalid!", title: "Email invalid");
      } else if (password.isEmpty) {
        showCustomSnackBar("Password is blank!", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than 6 characters!", title: "Password invalid");
      } else if (name.isEmpty) {
        showCustomSnackBar("Your name is blank!", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Phone number is blank!", title: "Phone number");
      } else {
        showCustomSnackBar("Processing...", title: "Success");
        SignUpModel signUpModel = SignUpModel(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpModel).then(
          (status) {
            if (status.isSuccess) {
              print("Success registration");
            }
            showCustomSnackBar(status.message);
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
            SizedBox(height: Dimensions.height15),
            AppFormField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: Dimensions.height20),
            AppFormField(
              textController: passwordController,
              hintText: "Password",
              icon: Icons.password,
            ),
            SizedBox(height: Dimensions.height20),
            AppFormField(
              textController: nameController,
              hintText: "Name",
              icon: Icons.person,
            ),
            SizedBox(height: Dimensions.height20),
            AppFormField(
              textController: phoneNumberController,
              hintText: "Phone",
              icon: Icons.phone,
            ),
            SizedBox(height: Dimensions.height45),
            GestureDetector(
              onTap: () {
                earlyCheckRegistration();
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: BigText(
                    text: "Sign up",
                    size: Dimensions.font20 + Dimensions.font26 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: "Have an account already?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height30 * 2),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: "Sign up using one of the following methods",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            Wrap(
              children: List.generate(
                3,
                (index) => CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundImage: AssetImage("assets/images/${signUpMethodImages[index]}"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
