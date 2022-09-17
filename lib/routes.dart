import 'package:flutter/material.dart';
import 'package:restaurant_app/home_page.dart';
import 'package:restaurant_app/list_restaurant.dart';
import 'package:restaurant_app/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';

  static const String homePageScreen = '/homePageScreen';
  static const String listRestaurant = '/listRestaurant';
  static const String detailRestaurant = '/detailRestaurant';

  static final Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => SplashScreen(),
    homePageScreen: (context) => const HomePage(),
    listRestaurant: (context) => ListRestaurant(
          query: 'all',
        ),
  };
}

void move(BuildContext context, String route,
    {bool replace = false, dynamic arguments}) {
  if (replace) {
    // delete this route from the history and replace it with the new route
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  } else {
    Navigator.pushNamed(context, route, arguments: arguments);
  }
}
