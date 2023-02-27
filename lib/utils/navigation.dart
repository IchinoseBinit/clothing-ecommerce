import 'package:flutter/material.dart';

import '/data/constants/routes_name.dart';
import '/screens/auth_screen/change_password_screen.dart';
import '/screens/auth_screen/edit_profile_screen.dart';
import '/screens/auth_screen/forgot_password_screen.dart';
import '/screens/auth_screen/login_screen.dart';
import '/screens/auth_screen/register_screen.dart';
import '/screens/auth_screen/welcome_screen.dart';
import '/screens/navigation_screen.dart';
import '/widgets/no_internet_screen.dart';

class Navigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.introRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const WelcomeScreen());

      case RoutesName.loginRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.registerRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());

      case RoutesName.forgotPasswordRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordScreen());

      // case RoutesName.homeRoute:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const MerchantListScreen());

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
