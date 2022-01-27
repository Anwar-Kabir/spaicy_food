import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ProductDetailes extends StatefulWidget {
  const ProductDetailes({Key? key}) : super(key: key);

  @override
  _ProductDetailesState createState() => _ProductDetailesState();
}

class _ProductDetailesState extends State<ProductDetailes> {

  final CollectionReference _productss =
  FirebaseFirestore.instance.collection('product_home');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Details"),
        ),
        body: Column(
          children: [

            Expanded(
              child: StreamBuilder(
                stream: _productss.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                        return Container(
                          height: 210,
                          width: 190,
                          child: GestureDetector(
                            onTap: (){
                              Get.to(ProductDetailes());
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                      height: 120,

                                      child: Image.network(documentSnapshot['img1'])),

                                  Text(documentSnapshot['name']),
                                  Text("${documentSnapshot['price'].toString()} \$"),
                                  //Text(" ${documentSnapshot['discount']} %"),
                                  Text("Sku ${documentSnapshot['sku']}"),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: SizedBox(),
                  );
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
