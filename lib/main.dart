import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/repository/provider/dashboard_provider.dart';
import 'package:restaurant_app/repository/provider/detail_provider.dart';
import 'package:restaurant_app/repository/provider/list_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'NongSkuy',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: Routes.routes,
        );
      },
    );
  }
}
