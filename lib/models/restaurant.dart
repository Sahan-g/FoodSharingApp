import 'package:flutter/material.dart';
import 'package:foodsharingplatform/models/food_Item.dart';
import 'package:foodsharingplatform/models/user.dart';

class Restaurant extends User {
  double donatedAmount;
  List<FoodItem> foodItems = [];

  Restaurant(
    int id,
    String username,
    String password,
    String name,
    String address,
    String email,
    String phone, {
    this.donatedAmount = 0.0,
  }) : super(id, username, password, email, address, phone, name);

  void addFoodItem(FoodItem foodItem) {
    foodItems.add(foodItem);
  }

  void removeFoodItem(FoodItem foodItem) {
    foodItems.remove(foodItem);
  }

  void viewAvailableFoodItems() {
    debugPrint("Available Food Items at $name:");
    for (var foodItem in foodItems) {
      debugPrint("${foodItem.name} - ${foodItem.description}");
    }
  }
}
