import 'package:clothing_ecommerce/screens/auth/edit_profile_screen.dart';
import 'package:clothing_ecommerce/screens/cart/cart_screen.dart';
import 'package:clothing_ecommerce/screens/home/home_screen.dart';
import 'package:clothing_ecommerce/screens/home/search_screen.dart';
import 'package:flutter/material.dart';

import '/data/constants/routes_name.dart';
import '/screens/navigation_screen.dart';
import '/widgets/no_internet_screen.dart';
import '../screens/auth/change_password_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/welcome_screen.dart';

class GenerateNavigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.introRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const WelcomeScreen());
      case RoutesName.homeRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case RoutesName.loginRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.registerRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());
      case RoutesName.forgotPasswordRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordScreen());
      case RoutesName.navigationRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NavigationScreen());
      case RoutesName.editProfileRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EditProfileScreen());
      case RoutesName.changePasswordRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ChangePasswordScreen());
      case RoutesName.connectivityCheckRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ConnectivityCheckWidget());
      case RoutesName.productSearchRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProductSearchScreen());
      case RoutesName.cartRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CartScreen());
      // case RoutesName.registerSetPasswordRoute:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const RegisterSetPasswordScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No where form here!"),
            ),
          );
        });
    }
  }
}
