import 'package:foodsharingplatform/models/food_item.dart';

class Request {
  DateTime date;
  List<FoodItem> requestedItems = [];
  String status;

  Request(this.date, this.status, {List<FoodItem>? requestedItems})
      : requestedItems = requestedItems ?? [];

  void addRequestedItem(FoodItem foodItem) {
    requestedItems.add(foodItem);
  }

  void removeRequestedItem(FoodItem foodItem) {
    requestedItems.remove(foodItem);
  }

  void updateStatus(String newStatus) {
    status = newStatus;
  }
}
