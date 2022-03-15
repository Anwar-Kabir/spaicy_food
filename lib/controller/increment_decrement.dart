import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetIncrementDecrement extends GetxController {
  RxInt val = 1.obs;

  int count = 1;

  /* delete() async {
   await FirebaseFirestore.instance
        .collection("users-favourite-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .doc(_documentSnapshot.id)
        .delete();
  } */

  addFire() {
    StreamBuilder(
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
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return Column(
                  children: [
                    Text(
                        ' Total product ${snapshot.data!.docs.length.toString()}'),
                  ],
                );
              });
        });
  }

  /* void countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('product').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(_myDocCount.length);  // Count of Documents in Collection
}
 } */

  add() {
    val++;
  }

  minus() {
    // val--;
    if (val > 1) {
      val--;
    }
  }
}
