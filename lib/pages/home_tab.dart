import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodsharingplatform/models/restaurant.dart';
import 'package:foodsharingplatform/pages/food_items.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final user = FirebaseAuth.instance.currentUser;

  List<Restaurant> restaurants = [];
  List<int> numberofitems = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> getRestaurantsData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Restaurant').get();

      restaurants = snapshot.docs.map((doc) {
        return Restaurant(
          id: doc.id,
          username: '',
          password: '',
          name: doc['name'],
          address: '',
          email: '',
          phone: '',
          imageUrl: doc['imageUrl'],
          donatedAmount: 0,
        );
      }).toList();
      for (var element in restaurants) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('Restaurant')
            .doc(element.id.toString())
            .collection('foodItems')
            .get();
        numberofitems.add(snapshot.docs.length);
      }

      print(restaurants);
    } catch (error) {
      debugPrint("Error getting restaurant data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Restaurants List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getRestaurantsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _navigateToFoodItemsPage(
                    restaurants[index].id.toString(),
                    restaurants[index].name.toString(),
                  );
                },
                child: Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image on top
                      Image.asset(
                        'assets/images/${restaurants[index].imageUrl}',
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      // Restaurant name
                      ListTile(
                        title: Text(
                          restaurants[index].name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        trailing: Text(
                            "${numberofitems[index]} Food items available",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 18, 179, 23))),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToFoodItemsPage(String id, String restaurantName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodItemsPage(
          restaurantName: restaurantName,
          id: id,
        ),
      ),
    );
  }
}
