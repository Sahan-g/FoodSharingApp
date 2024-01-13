import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Display your "Account" tab content here
          Text(
            "Handle Account",
          )
          // Example: User information, settings, etc.
        ],
      ),
    );
  }
}
