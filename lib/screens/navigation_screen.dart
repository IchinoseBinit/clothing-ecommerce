// ignore_for_file: unnecessary_null_comparison
import 'package:clothing_ecommerce/screens/auth/profile_screen.dart';
import 'package:clothing_ecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '/styles/app_colors.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  late List<Widget> navScreens = <Widget>[
    HomeScreen(),
    HomeScreen(),
    const ProfileScreen(),
    // const UpcomingOrderListScreen(),
    // const ProfileScreen()
  ];

  _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: navScreens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.textDarkColor,
          selectedItemColor: AppColors.primaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home_filled,
                color: AppColors.primaryColor,
              ),
              icon: Icon(
                Icons.home_outlined,
                color: AppColors.textDarkColor,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.format_list_bulleted,
                color: AppColors.primaryColor,
              ),
              icon: Icon(
                Icons.format_list_bulleted,
                color: AppColors.textDarkColor,
              ),
              label: "Order",
              backgroundColor: AppColors.textDarkColor,
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
              icon: Icon(
                Icons.person_outline,
                color: AppColors.textDarkColor,
              ),
              label: "Profile",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap),
    );
  }
}
