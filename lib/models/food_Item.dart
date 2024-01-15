import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodItem {
  String? id;
  String? name;
  String? description;
  int? quantity;
  double? unitPrice;
  String? icon;

  FoodItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.quantity,
      required this.unitPrice,
      required this.icon});

  factory FoodItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return FoodItem(
      id: snapshot.id,
      name: data['itemName'],
      description: data['description'],
      quantity: data['availableQuantity'],
      unitPrice: data['unitprice'],
      icon: data['icon'],
    );
  }
}
  // void updateDescription(String newDescription) {
  //   description = newDescription;
  // }

  // void decreaseQuantity(int amount) {
  //   if (amount > 0 && amount <= quantity) {
  //     quantity -= amount;
  //   } else {
  //     debugPrint("Invalid quantity to decrease.");
  //   }
  // }

