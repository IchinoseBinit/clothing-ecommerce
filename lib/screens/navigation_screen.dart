// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import '/screens/auth_screen/profile_screen.dart';
import '/styles/app_colors.dart';
import 'order/upcoming_order_list_screen.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  late List<Widget> meroWidget = <Widget>[
    // const MerchantListScreen(),
    // const FavouriteMerchantListScreen(),
    // const CartScreen(),
    const UpcomingOrderListScreen(),
    const ProfileScreen()
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
        child: meroWidget.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.textDarkColor,
          selectedItemColor: AppColors.primaryColor,
          items: const <BottomNavigationBarItem>[
            // BottomNavigationBarItem(
            //   activeIcon: Icon(
            //     Icons.home,
            //     color: AppColors.primaryColor,
            //   ),
            //   icon: Icon(
            //     Icons.home_outlined,
            //     color: AppColors.textDarkColor,
            //   ),
            //   label: "Home",
            // ),
            // BottomNavigationBarItem(
            //   activeIcon: Icon(
            //     Icons.favorite_outlined,
            //     color: AppColors.primaryColor,
            //   ),
            //   icon: Icon(
            //     Icons.favorite_outline,
            //     color: AppColors.textDarkColor,
            //   ),
            //   label: "Favourite",
            // ),
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
