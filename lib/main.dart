import 'package:flutter/material.dart';
import 'package:foodsharingplatform/pages/home_page.dart';
import 'package:foodsharingplatform/pages/login_page.dart';
import 'package:foodsharingplatform/pages/main_page.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';
import "package:firebase_core/firebase_core.dart";
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FoodSharingApp());
}

class FoodSharingApp extends StatelessWidget {
  const FoodSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.background,
      ),
      /*routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/main': (context) => MainPage()
      }*/
      home: MainPage(),
    );
  }
}
