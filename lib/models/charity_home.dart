import 'package:foodsharingplatform/models/request.dart';
import 'package:foodsharingplatform/models/user.dart';

class CharityHome extends User {
  List<Request> requests = [];

  CharityHome(
    String id,
    String username,
    String password,
    String email,
    String address,
    String phone,
    String name,
  ) : super(id, username, password, email, address, phone, name);

  void makeRequest(Request request) {
    requests.add(request);
  }

  void viewAvailableRestaurants() {}
}
