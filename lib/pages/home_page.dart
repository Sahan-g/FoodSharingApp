import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsharingplatform/pages/account_tab.dart';
import 'package:foodsharingplatform/pages/home_tab.dart';
import 'package:foodsharingplatform/pages/my_requests.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          backgroundColor: AppColors.background,
          color: Colors.white,
          activeColor: const Color.fromRGBO(255, 255, 255, 1),
          tabBackgroundColor: const Color.fromARGB(255, 208, 180, 41),
          padding: const EdgeInsets.all(16),
          onTabChange: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.add_box,
              text: 'My requests',
            ),
            GButton(
              icon: Icons.account_box_outlined,
              text: 'Account',
            ),
          ],
          gap: 20,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Share Kindly"),
        centerTitle: false,
      ),
      body: _buildBody(selectedIndex),
    );
  }

  Widget _buildBody(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeTab();
      case 1:
        return const MyRequest();
      case 2:
        return const AccountTab();
      default:
        return Container();
    }
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

List<Widget> mockRestaurnatsList() {
  List<Widget> restaurnts = [];
  for (int i = 0; i < 20; i++) {
    restaurnts.add(_foodItem());
  }
  return restaurnts;
}
