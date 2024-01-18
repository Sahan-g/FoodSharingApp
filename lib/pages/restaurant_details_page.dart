import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final String restaurantId;

  RestaurantDetailsPage({required this.restaurantId});

  Future<List<Object?>> getFoodItems() async {
    try {
      QuerySnapshot foodItemsSnapshot = await FirebaseFirestore.instance
          .collection('Restaurant')
          .doc(restaurantId)
          .collection('foodItems')
          .get();

      return foodItemsSnapshot.docs.map((item) => item.data()).toList();
    } catch (error) {
      debugPrint("Error getting food items: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFoodItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Map<String, dynamic>> foodItems =
            snapshot.data as List<Map<String, dynamic>>;

        return Scaffold(
          appBar: AppBar(
            title: Text('Food Items'),
          ),
          body: foodItems.isEmpty
              ? Center(
                  child: Text('No Food Items Available'),
                )
              : ListView.builder(
                  itemCount: foodItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(foodItems[index]['name'].toString()),
                      subtitle:
                          Text(foodItems[index]['description'].toString()),
                      // Add other details if needed

                      // Show availability status
                      trailing: Text(
                        (foodItems[index]['availableQuantity'] ?? 0) > 0
                            ? 'Available'
                            : 'Not Available',
                        style: TextStyle(
                          color:
                              (foodItems[index]['availableQuantity'] ?? 0) > 0
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
