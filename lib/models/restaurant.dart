import 'package:flutter/material.dart';
import 'package:foodsharingplatform/models/food_item.dart';
import 'package:foodsharingplatform/models/user.dart';

class Restaurant extends User {
  double? donatedAmount;
  List<FoodItem> foodItems = [];

  Restaurant({
    this.donatedAmount = 0.0,
    required String id,
    required name,
    required String username,
    required address,
    required phone,
    required imageUrl,
    required email,
    required String password,
  }) : super(id, username, password, email, address, phone, name, imageUrl);
}
