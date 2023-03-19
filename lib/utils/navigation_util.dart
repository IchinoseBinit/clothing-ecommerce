import 'package:flutter/material.dart';

navigate(BuildContext context, Widget screen,{bool fullscreenDialog=false}) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      fullscreenDialog: fullscreenDialog
    ),
  );
}

navigateNamedReplacement(BuildContext context, String routeName) {
  return Navigator.pushReplacementNamed(
    context,
    routeName,
  );
}

navigateNamed(BuildContext context, String screen) {
  return Navigator.pushNamed(
    context,
   screen
  );
}

navigateReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

navigateNamedUntil(BuildContext context, {required Widget screen}) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (route) => false,
  );
}

navigateUntil(BuildContext context, {required Widget screen}) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (route) => false,
  );
}
