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
                                      Text("\$ ${_documentSnapshot['price']}"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if(count>1){
                                                count--;
                                              }


                                            });
                                          },
                                          icon: Icon(
                                              Icons.remove_circle_outline)),
                                      Text(count.toString()),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              count++;
                                            });
                                          },
                                          icon: Icon(Icons.add_circle_outline))
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
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
