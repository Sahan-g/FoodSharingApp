import 'package:flutter/material.dart';

class MyRequest extends StatelessWidget {
  const MyRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Display your "My requests" tab content here
          // Example: A list of mock restaurants
          Column(
            children: mockRestaurantsList(),
          ),
        ],
      ),
    );
  }
}

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
