import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsharingplatform/models/charity_home.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  late Future<CharityHome> charityFuture;

  Future<CharityHome> getDetails() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('CharityUser')
        .where('email',
            isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    var obj = snapshot.docs[0];
    _nameController.text = obj['organizationName'];
    _addressController.text = obj['address'];
    _phoneController.text = obj['phoneNo'];
    return CharityHome(
        id: obj.id,
        username: obj['email'],
        password: " ",
        email: obj['email'],
        address: obj['address'],
        phone: obj['phoneNo'],
        name: obj['organizationName'],
        imageUrl: ' ');
  }

  @override
  void initState() {
    super.initState();

    charityFuture = getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Info',
        ),
        backgroundColor: const Color.fromARGB(255, 10, 53, 88),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Organization Name",
                      style: TextStyle(
                          color: AppColors.white, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                TextField(
                  textAlign: TextAlign.left,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Organization Name",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Address",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: "Address",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Phone Number",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone number",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => {
                      editUserInfo(_addressController.text,
                          _phoneController.text, _nameController.text),
                      Navigator.pop(context)
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Save Changes"),
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editUserInfo(String address, String phone, String name) async {
    QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore.instance
        .collection('CharityUser')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();

    if (docs.docs.isNotEmpty) {
      DocumentReference ref = docs.docs.first.reference;

      await ref.update(
          {'address': address, 'phoneNo': phone, 'organizationName': name});
    }
  }
}
