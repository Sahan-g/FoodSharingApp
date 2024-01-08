import 'package:flutter/material.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Food For All"),
        centerTitle: false,
      ),
      body: Center(
        child: ListView(
          children: mockRestaurnatsList(),
        ),
      ),
    );
  }
}

Widget _foodItem() {
  return Row(children: [
    Image.asset(
      'assets/images/logo.png',
      height: 40,
      width: 40,
    ),
    const Text("Restaurant Name"),
    const SizedBox(
      width: 8,
    ),
  ]);
}

List<Widget> mockRestaurnatsList() {
  List<Widget> restaurnts = [];
  for (int i = 0; i < 20; i++) {
    restaurnts.add(_foodItem());
  }
  return restaurnts;
}
