import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsharingplatform/models/food_item.dart';
import 'package:foodsharingplatform/pages/make_request.dart';

class FoodItemsPage extends StatefulWidget {
  final String restaurantName;
  final String id;

  const FoodItemsPage(
      {Key? key, required this.restaurantName, required this.id})
      : super(key: key);

  @override
  State<FoodItemsPage> createState() => _FoodItemsPageState();
}

class _FoodItemsPageState extends State<FoodItemsPage> {
  List<FoodItem> fooditems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.restaurantName} ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: getFoodItems(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: fooditems.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.lightBlueAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: Text(
                        "${fooditems[index].name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        "Description: ${fooditems[index].description}\n"
                        "Quantity: ${fooditems[index].quantity}\n"
                        "Unit Price: ${fooditems[index].unitPrice}",
                        style: TextStyle(color: Colors.black87),
                      ),
                      leading: Image.asset(
                        'assets/images/${fooditems[index].icon}',
                        width: 50,
                        height: 50,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          // Navigate to a new screen here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MakeRequestPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getFoodItems(String id) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Restaurant')
        .doc(id.toString())
        .collection('foodItems')
        .get();

    fooditems = snapshot.docs.map((doc) {
      print("Document data: ${doc.data()}");

      return FoodItem(
        name: doc['itemName'] as String,
        quantity: (doc['availableQuantity'] as num).toInt(),
        description: doc['description'] as String,
        unitPrice: (doc['unitprice'] as num).toDouble(),
        icon: doc['icon'] as String,
      );
    }).toList();
  }
}
