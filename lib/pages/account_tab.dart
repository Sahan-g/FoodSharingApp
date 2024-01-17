import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsharingplatform/Auth/main_page.dart';
import 'package:foodsharingplatform/models/charity_home.dart';
import 'package:foodsharingplatform/pages/edit_account_page.dart';
import 'package:foodsharingplatform/pages/login_page.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<CharityHome> charityFuture;

  Future<CharityHome> getDetails() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('CharityUser')
        .where('username',
            isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    var obj = snapshot.docs[0];
    return CharityHome(
        id: obj.id,
        username: obj['username'],
        password: " ",
        email: obj['username'],
        address: obj['address'],
        phone: obj['phoneNo'],
        name: obj['organizationName'],
        imageUrl: ' ');
  }

  @override
  void initState() {
    super.initState();
    charityFuture = getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.account_box),
            const SizedBox(
              width: 20,
            ),
            const Text(
              'My Account',
            ),
            const Expanded(
                child: SizedBox(
              child: null,
            )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditAccount()));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 10, 53, 88),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<CharityHome>(
          future: charityFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            } else {
              CharityHome charity = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColors.fontSecondary,
                    ),
                    child: Text(
                      'Organization Name: ${charity.name}',
                      style: const TextStyle(
                        color: AppColors.fontPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColors.fontSecondary,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Address: ${charity.address}',
                            style: const TextStyle(
                              color: AppColors.fontPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColors.fontSecondary,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.call,
                          color: AppColors.fontPrimary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Phone Number: ${charity.phone}',
                          style: const TextStyle(
                            color: AppColors.fontPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColors.fontSecondary,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          color: AppColors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Email: ${charity.email}',
                          style: const TextStyle(
                            color: AppColors.fontPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(child: Container()),
                  const Divider(thickness: 2, color: Colors.grey),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("SignOut"),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
