import 'package:flutter/material.dart';
import 'package:untitled1/RealEstateScreen/real_state.dart';
import 'package:untitled1/SuperShop/super_shop_home_screen.dart' hide HomeScreen;
import 'package:untitled1/WeatherScreen/wather_home_screen.dart';
import 'All Screen/all_screens_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AllScreensPage(
        destinations: const [
          HomeScreen(),          // Real Estate
          WeatherHomeScreen(),   // Weather
          SuperShopApp(),        // Super Shop
        ],
      ),
    );
  }
}