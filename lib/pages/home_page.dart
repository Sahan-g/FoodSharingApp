import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foodsharingplatform/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Share Kindly"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(user!.uid),
            // Wrap the ListView with a Container and specify a height
            SizedBox(
              height: 600,
              // Set an appropriate height
              child: Center(
                child: ListView(
                  children: mockRestaurantsList(),
                ),
              ),
            ),
            TextButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

// ...

List<Widget> mockRestaurantsList() {
  List<Widget> restaurants = [];
  for (int i = 0; i < 20; i++) {
    restaurants.add(_foodItem());
  }
  return restaurants;
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
