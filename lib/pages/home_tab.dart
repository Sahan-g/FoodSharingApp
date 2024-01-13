import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final user = FirebaseAuth.instance.currentUser;
  List<String> docIds = [];

  @override
  void initState() {
    super.initState();
    getDocId();
  }

  Future<void> getDocId() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Restaurant').get();

      docIds.clear();

      snapshot.docs.forEach((element) {
        docIds.add(element.reference.id);
      });

      print(docIds);
    } catch (error) {
      debugPrint("Error getting document IDs: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            AppColors.background, // Change this to your desired color
        title: Text(
          "Restaurant List",
          style: TextStyle(color: Colors.white), // Change text color
        ),
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Use the docIds list to build your ListView
          return ListView.builder(
            itemCount: docIds.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3, // Add elevation for a shadow effect
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    'Restaurant Name ${docIds[index]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Add bold text
                      color: Colors.blue, // Change text color
                    ),
                  ),
                  subtitle: Text(
                    'Additional details if needed',
                    style: TextStyle(color: Colors.grey), // Change text color
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
