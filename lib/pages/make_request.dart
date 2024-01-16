import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsharingplatform/models/food_item.dart';
import 'package:foodsharingplatform/models/request.dart';
import 'package:foodsharingplatform/styles/app_colors.dart';

class MakeRequestPage extends StatefulWidget {
  const MakeRequestPage({
    Key? key,
    required this.restaurantid,
    required this.itemId,
  }) : super(key: key);

  final String restaurantid;
  final String itemId;

  @override
  State<MakeRequestPage> createState() => _MakeRequestPageState();
}

class _MakeRequestPageState extends State<MakeRequestPage> {
  late Future<FoodItem> future;
  final _amountController = TextEditingController();
  int count = 1;
  late FoodItem item;

  @override
  void initState() {
    super.initState();
    future = getItem(widget.restaurantid, widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 154, 154, 154),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Make a Request",
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<FoodItem>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              } else {
                item = snapshot.data!;
                return SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Image.asset('assets/images/${item.icon}'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 251, 251, 251),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${item.name}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Available Amount : ${item.quantity}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 18, 179, 23),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: count > 0
                                      ? () {
                                          setState(() {
                                            count--;
                                            _amountController.text =
                                                count.toString();
                                          });
                                        }
                                      : null,
                                  icon: const Icon(Icons.remove),
                                ),
                                Container(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    controller: _amountController,
                                    onChanged: (value) {
                                      setState(() {
                                        count = int.tryParse(value) ?? 1;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Amount",
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: count < (item.quantity ?? 1)
                                      ? () {
                                          setState(() {
                                            count++;
                                            _amountController.text =
                                                count.toString();
                                          });
                                        }
                                      : null,
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                DateTime currentDate = DateTime.now();
                Request r = Request(
                  id: "11",
                  date: DateTime(
                    currentDate.year,
                    currentDate.month,
                    currentDate.day,
                  ).toString(),
                  fooditem: item.name ?? " ",
                  quantity: int.tryParse(_amountController.text) ?? 1,
                  status: "Pending",
                  userid: FirebaseAuth.instance.currentUser!.uid.toString(),
                  restaurantId: widget.restaurantid,
                );

                makeRequest(r, item.id ?? '');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Confirm Request"),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}

Future<FoodItem> getItem(String restaurantid, String itemId) async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection("Restaurant")
      .doc(restaurantid)
      .collection('foodItems')
      .doc(itemId)
      .get();
  FoodItem item = FoodItem.fromDocumentSnapshot(snapshot);

  return item;
}

Future<void> makeRequest(Request r, String itemId) async {
  try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      await FirebaseFirestore.instance.collection('Request').add({
        'date': r.date,
        'fooditem': r.fooditem,
        'userid': r.userid,
        'quantity': r.quantity,
        'restaurantid': r.restaurantId,
        'status': r.status,
      });

      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("Restaurant")
          .doc(r.restaurantId)
          .collection('foodItems')
          .doc(itemId)
          .get();

      final oldFoodItem = FirebaseFirestore.instance
          .collection('Restaurant')
          .doc(r.restaurantId)
          .collection('foodItems')
          .doc(itemId);
      // oldFoodItem.update(
      //     {'availableQuantity': snapshot['availableQuantity'] - r.quantity});
      DocumentReference foodItemRef = FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(r.restaurantId)
          .collection('foodItems')
          .doc(itemId);

      DocumentSnapshot foodItemSnapshot = await transaction.get(foodItemRef);
      int currentQuantity = foodItemSnapshot['availableQuantity'];

      transaction.update(foodItemRef, {
        'availableQuantity': currentQuantity - r.quantity,
      });
    });
  } catch (e) {
    print(e);
  }
}
