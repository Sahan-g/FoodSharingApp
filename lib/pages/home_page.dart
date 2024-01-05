import 'package:flutter/material.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Food Share"),
        centerTitle: false,
      ),
      body: Center(child: Text("Hello this is home page")),
    );
  }
}
