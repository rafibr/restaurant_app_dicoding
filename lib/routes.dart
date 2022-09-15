import 'package:flutter/material.dart';
import 'package:restaurant_app/splash_screen.dart';

class Routes {
  static const String root = '/root';

  static final Map<String, Widget Function(BuildContext)> routes = {
    root: (context) => SplashScreen(),
  };
}

void move(BuildContext context, String route, {bool replace = false, dynamic arguments}) {
  if (replace) {
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  } else {
    Navigator.pushNamed(context, route, arguments: arguments);
  }
}
