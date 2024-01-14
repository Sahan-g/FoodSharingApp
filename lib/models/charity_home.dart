import 'package:foodsharingplatform/models/request.dart';
import 'package:foodsharingplatform/models/user.dart';

class CharityHome extends User {
  List<Request> requests = [];

  CharityHome(
      {required String id,
      required String username,
      required String password,
      required String email,
      required String address,
      required String phone,
      required String name,
      required String imageUrl})
      : super(id, username, password, email, address, phone, name, imageUrl);
  void makeRequest(Request request) {
    requests.add(request);
  }

  void viewAvailableRestaurants() {}
}
