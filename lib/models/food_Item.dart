import 'package:flutter/material.dart';

class FoodItem {
  String name;
  double unitPrice;
  int quantity;
  String description;

  FoodItem(this.name, this.unitPrice, this.quantity, this.description);

  void updateDescription(String newDescription) {
    description = newDescription;
  }

  void decreaseQuantity(int amount) {
    if (amount > 0 && amount <= quantity) {
      quantity -= amount;
    } else {
      debugPrint("Invalid quantity to decrease.");
    }
  }
}
