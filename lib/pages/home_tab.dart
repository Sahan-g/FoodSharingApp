import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(user!.email.toString()),
          // Display your home tab content here
          // Example: A list of mock restaurants
        ],
      ),
    );
  }
}
