import 'package:flutter/material.dart';
import 'package:restaurant_app/routes.dart';
import 'package:restaurant_app/style/text_theme.style.dart';

void main() {
  runApp(
    const NongSkuy(),
  );
}

class NongSkuy extends StatelessWidget {
  const NongSkuy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nongskuy',
      theme: ThemeData(textTheme: myTextTheme),
      initialRoute: Routes.splashScreen,
      routes: Routes.routes,
    );
  }
}
