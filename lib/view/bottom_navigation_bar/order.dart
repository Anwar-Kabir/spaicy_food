import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:shimmer/shimmer.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //Text(' Total product ${snapshot.data!.docs.length.toString()}'),

          children: [
            Container(
              padding: EdgeInsets.only(
                left: 3,
              ),
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 3, top: 7, right: 6),
                            width: 13,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Deliver to NAME address line 1...',
                                  style: TextStyle(fontSize: 15)),
                              Text('click here to change address',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users-cart-items")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("items")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Some thing is Wrong"),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot _documentSnapshot =
                              snapshot.data!.docs[index];
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  leading: Container(
                                      height: 120,
                                      width: 90,
                                      child: Image.network(
                                          _documentSnapshot['images'])),
                                  title: Text(_documentSnapshot['name']),
                                  subtitle: Row(
                                    children: [
                                      Text("\$ ${_documentSnapshot['price']*count}"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (count > 1) {
                                                count--;
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red,
                                          )),
                                      Text(count.toString()),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              count++;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.green,
                                          ))
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("users-cart-items")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection("items")
                                          .doc(_documentSnapshot.id)
                                          .delete();

                                      Get.snackbar(
                                        "hitaishi-food",
                                        "Delete, Product from cart Successful",
                                        icon: Icon(Icons.person,
                                            color: Colors.green),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 3),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  }),
            ),
            Container(
                height: 100,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Promo Code',
                        ),
                      ),
                    ])),
            SizedBox(
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {},
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            /*Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: Container(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: Image.asset(
                      "assets/images/empty_shopping_cart.png",
                      height: 250,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Container(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "You haven't anything to cart",
                      style: TextStyle(
                        color: Color(0xFF67778E),
                        fontFamily: 'Roboto-Light.ttf',
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
