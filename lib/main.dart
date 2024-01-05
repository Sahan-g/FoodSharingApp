import 'package:flutter/material.dart';
import 'package:foodsharingplatform/pages/login_page.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';

void main() {
  runApp(FoodSharingApp());
}

class FoodSharingApp extends StatelessWidget {
  const FoodSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.background,
      ),
    );
  }
}
