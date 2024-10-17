import 'package:flutter/material.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/cart/cart_history_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  List<Widget> _screens() {
    return [
      const MainFoodPage(),
      const Center(child: Text("next page")),
      const CartHistoryPage(),
      const AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey.shade900,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.archive),
        title: ("Archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey.shade900,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: ("Orders"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey.shade900,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.grey.shade900,
      ),
    ];
  }

  // void onTapNavigation(int index) {
  //   setState(
  //     () {
  //       _selectedIndex = index;
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: Colors.amberAccent,
  //       showSelectedLabels: true,
  //       showUnselectedLabels: true,
  //       currentIndex: _selectedIndex,
  //       onTap: onTapNavigation,
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_max_outlined),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.archive),
  //           label: "History",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.shopping_cart),
  //           label: "Orders",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person),
  //           label: "Me",
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 8),
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style3,
    );
  }
}
