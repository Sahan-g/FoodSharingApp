abstract class User {
  String id;
  String username;
  String password;
  bool isLoggedIn;
  String email;
  String address;
  String phone;
  String name;

  User(this.id, this.username, this.password, this.email, this.address,
      this.phone, this.name,
      {this.isLoggedIn = false});

  void register(String username, String password, String email, String address,
      String phone, String name) {
    this.username = username;
    this.password = password;
    this.email = email;
    this.address = address;
    this.phone = phone;
    this.name = name;
  }

  void updateProfile(String newUsername, String newPassword, String newEmail,
      String newAddress, String newPhone, String newName) {
    username = newUsername;
    password = newPassword;
    email = newEmail;
    address = newAddress;
    phone = newPhone;
    name = newName;
  }

  void login() {
    isLoggedIn = true;
  }
}
