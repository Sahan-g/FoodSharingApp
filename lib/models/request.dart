import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodsharingplatform/models/food_item.dart';

class Request {
  String id;
  String date;
  String fooditem;
  int quantity;
  String userid;
  String restaurantId;
  String status;

  Request(
      {required this.id,
      required this.date,
      required this.fooditem,
      required this.quantity,
      required this.status,
      required this.userid,
      required this.restaurantId});

  factory Request.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Request(
        id: snapshot.id,
        fooditem: data['fooditem'],
        status: data['status'],
        quantity: data['quantity'],
        userid: data['userid'],
        restaurantId: data['restaurantid'],
        date: data['date']);
  }

  void updateStatus(String newStatus) {
    status = newStatus;
  }
}
