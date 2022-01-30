import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/signin_signup/signin.dart';

class ProductDetailes extends StatefulWidget {
  var productdetail;

  ProductDetailes({Key? key, required this.productdetail})
      : super(
          key: key,
        );

  @override
  _ProductDetailesState createState() => _ProductDetailesState();
}

class _ProductDetailesState extends State<ProductDetailes> {
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('product_home');

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.productdetail['name'],
      "price": widget.productdetail['price'],
      "images": widget.productdetail['img1'],
    }).then((value) => print("Added to cart"));
  }

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.productdetail['name'],
      "price": widget.productdetail['price'],
      "images": widget.productdetail['img1'],
    }).then((value) => print("Added to favourite"));
  }

  logincheck() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.off(Signin());
        Get.snackbar(
          "hitaishi-food",
          "Please sign in first",
          //icon: Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        );
      } else {
        print('User is signed in!');
        //Get.off(MyHomePage());
        addToCart();
        Get.snackbar(
          "hitaishi-food",
          "Product Add to card Successful",
          icon: Icon(Icons.person, color: Colors.green),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Details"),
        ),
        body: Column(children: [
          Container(
              height: 120,
              width: 110,
              child: Image.network(widget.productdetail['img1'].toString())),
          Text(widget.productdetail['name'].toString()),
          Text(widget.productdetail['price'].toString()),
          Text(widget.productdetail['sku'].toString()),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.yellow,
                  ),
                ),
                child:

                    /*StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("items-fav").where("name",isEqualTo: widget.productdetail['product-name']).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.data==null){
                      return Text("");
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () => snapshot.data.docs.length==0?addToFavourite():"Already Added",
                        icon: snapshot.data.docs.length==0? Icon(
                          Icons.favorite_outline,
                          color: Colors.black54,
                        ):Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },

                ),*/

                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users-favourite-items")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items-fav")
                            .where("name",
                                isEqualTo: widget.productdetail['product-name'])
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Text("");
                          }
                          return IconButton(
                            icon: snapshot.data.docs.length == 0
                                ? Icon(
                                    Icons.favorite_outline,
                                  )
                                : Icon(
                                    Icons.favorite,
                              color: Colors.red,
                                  ),
                            onPressed: () {
                              snapshot.data.docs.length == 0
                                  ? addToFavourite()
                                  : 'Already added';
                              Get.snackbar(
                                "hitaishi-food",
                                "Successfully product added to Favourite",
                                icon: Icon(Icons.person, color: Colors.green),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: Duration(seconds: 3),
                              );
                            },
                          );
                        }),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.yellow,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
                  ),
                  onPressed: () {
                    logincheck();
                  },
                ),
              ),




              Expanded(
                child: SizedBox(
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
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
