import 'package:flutter/material.dart';
import 'package:foodsharingplatform/login_page.dart';

void main() {
  runApp(FoodSharingApp());
}

class FoodSharingApp extends StatelessWidget {
  const FoodSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
