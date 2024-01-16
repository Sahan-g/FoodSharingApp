import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsharingplatform/models/request.dart';
import 'package:foodsharingplatform/models/restaurant.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({super.key});

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Request> reqList = [];
  List<Restaurant> resList = [];

  Future<void> getData() async {
    var result = await FirebaseFirestore.instance
        .collection("Request")
        .where('userid', isEqualTo: _auth.currentUser!.uid)
        .get();

    reqList = result.docs.map((doc) {
      return Request.fromDocumentSnapshot(doc);
    }).toList();

    for (var element in reqList) {
      var resDoc = await FirebaseFirestore.instance
          .collection("Restaurant")
          .doc(element.restaurantId)
          .get();

      if (resDoc.exists) {
        Restaurant restaurant = Restaurant(
          id: resDoc.id,
          name: resDoc['name'],
          username: '',
          address: resDoc['address'],
          phone: resDoc['phone'],
          imageUrl: resDoc['imageUrl'],
          email: " ",
          password: '',
        );

        resList.add(restaurant);
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 53, 88),
        title: const Text(
          "My Requests",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: getData(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return ListView.builder(
                    itemCount: reqList.length,
                    itemBuilder: (context, index) {
                      Request request = reqList[index];
                      Restaurant restaurant =
                          resList[index]; // Assuming resList is available

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Color.fromARGB(230, 246, 245, 245),
                              ),
                              child: ListTile(
                                title: Text("Restaurant: ${restaurant.name}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Food Item: ${request.fooditem}"),
                                    Text("Quantity: ${request.quantity}"),
                                    Text("Date: ${request.date}"),
                                    Text("ID: ${request.id}"),
                                    Row(
                                      children: [
                                        const Text("Status: "),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color:
                                                _getTileColor(request.status),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(3, 1, 2, 3),
                                            child: Text('${request.status}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        "Address: ${restaurant.address}"), // phone icon
                                    Text(
                                        "Phone: ${restaurant.phone}"), //location icon
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      );
                    },
                  );
                })),
          ),
        ],
      ),
    );
  }

  Color _getTileColor(String s) {
    switch (s.toLowerCase()) {
      case 'pending':
        return Colors.yellowAccent;
      case 'confirmed':
        return Colors.greenAccent;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return const Color.fromARGB(253, 255, 255, 255);
    }
  }
}
