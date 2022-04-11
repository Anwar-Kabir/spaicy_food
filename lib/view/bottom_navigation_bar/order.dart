import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spaicy_food/controller/increment_decrement.dart';
import 'package:spaicy_food/view/checkout.dart';
import 'package:spaicy_food/view/my_home_page.dart';
import 'package:spaicy_food/view/signin_signup/signin.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int count = 1;

  final GetIncrementDecrement abc = Get.put(GetIncrementDecrement());

  @override
  void initState() {
    super.initState();
    logincheck();
  }

  logincheck() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.off(const Signin());
      } else {
        print('User is signed in!');
        Get.off(const MyHomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //Text(' Total product ${snapshot.data!.docs.length.toString()}'),

          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                child: const Text(
                  'Use coupun & get 25% off',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 3,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users-cart-items")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("items")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot _documentSnapshot =
                              snapshot.data!.docs[index];
                          return Column(
                            children: [
                              /* Text(
                                  ' Total product ${snapshot.data!.docs.length.toString()}'),
                              Text(
                                  ' Total Price ${_documentSnapshot['price'] * abc.val.value}'), */
                              Card(
                                elevation: 3,
                                child: ListTile(
                                  leading: Container(
                                      height: 120,
                                      width: 90,
                                      child: Image.network(
                                          _documentSnapshot['images'])),
                                  title: Text(_documentSnapshot['name']),
                                  subtitle: Row(
                                    children: [
                                      Obx(() => Text(
                                          " ${_documentSnapshot['price']} x ${abc.val.value}   \$ ${_documentSnapshot['price'] * abc.val.value}")),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                      ),
                                      IconButton(
                                          onPressed: () => abc.add(),
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.green,
                                          )),
                                      Obx(() => Text(abc.val.toString())),
                                      IconButton(
                                          onPressed: () => abc.minus(),
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red,
                                          )),
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

            /*Container(
                height: 50,
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
                    ])),*/

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: const EdgeInsets.all(8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /* Text(
                            "${abc.addFire().data!.docs.length.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ), */
                          Text(
                            "Total Item",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            "\$ 567",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Total Amount",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          onPressed: () {
                            Get.to(CheckOut());
                          },
                          child: Text(
                            "Check Out".toUpperCase(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
