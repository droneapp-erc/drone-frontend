import 'package:flutter/material.dart';
import 'package:frontend/HomePage.dart';
import 'package:get/get.dart';
import 'CalculationPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Drone App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/calculation', page: () => const CalculationPage()),
      ],
    );
  }
}
