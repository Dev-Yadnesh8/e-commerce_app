import 'package:e_commerce_app/provider/product_data_provider.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/screens/details_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ProductProvider(),child: MaterialApp(
      theme: lightMode,
      home: HomeScreen(),
      routes: {
        '/homeScreen' : (context) => const HomeScreen(),
        '/cartScreen' : (context) => const CartScreen(),
      },
    ));

  }
}

