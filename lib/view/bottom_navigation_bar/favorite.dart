import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:spaicy_food/view/product/product_show.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favourite-items")
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
                              subtitle:  Text('\$ ${_documentSnapshot['price']}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete_forever,color: Colors.red,),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("users-favourite-items")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("items")
                                      .doc(_documentSnapshot.id)
                                      .delete();

                                  Get.snackbar(
                                    "hitaishi-food",
                                    "Delete, Product from cart Successful",
                                    icon:
                                        Icon(Icons.person, color: Colors.green),
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
            width: double.infinity,
            height: 250,
            child: Image.asset(
              "assets/images/empty_wish_list.png",
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
              "You haven't anything to wish List",
              style: TextStyle(
                color: Color(0xFF67778E),
                fontFamily: 'Roboto-Light.ttf',
                fontSize: 20,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.center,
            ),
          )*/
      ],
    ));
  }
}
