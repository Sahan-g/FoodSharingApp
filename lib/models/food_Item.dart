import 'package:flutter/material.dart';

class FoodItem {
  String? name;
  String? description;
  int? quantity;
  double? unitPrice;
  String? icon;

  FoodItem(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.unitPrice,
      required this.icon});
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

