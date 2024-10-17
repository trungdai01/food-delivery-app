import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/profile_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Center(
          child: BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        // child: ListView()
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height15 * 5,
              size: Dimensions.height15 * 10,
            ),
            SizedBox(height: Dimensions.height20),
            Expanded(
              child: ListView(
                children: [
                  ProfileWidget(
                    appIcon: AppIcon(
                      icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: const BigText(text: "name"),
                  ),
                  ProfileWidget(
                    appIcon: AppIcon(
                      icon: Icons.phone,
                      backgroundColor: AppColors.yellowColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: const BigText(text: "090910JQKA"),
                  ),
                  ProfileWidget(
                    appIcon: AppIcon(
                      icon: Icons.email,
                      backgroundColor: AppColors.yellowColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: const BigText(text: "admin@email.com"),
                  ),
                  ProfileWidget(
                    appIcon: AppIcon(
                      icon: Icons.location_on,
                      backgroundColor: AppColors.yellowColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: const BigText(text: "Fill in your address"),
                  ),
                  ProfileWidget(
                    appIcon: AppIcon(
                      icon: Icons.message,
                      backgroundColor: Colors.redAccent,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: const BigText(text: "Amen!"),
                  ),
                  ProfileWidget(
                    appIcon: AppIcon(
                      icon: Icons.logout,
                      backgroundColor: Colors.redAccent,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height10 * 5 / 2,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: const BigText(text: "Log out"),
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
