import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/product/product_detailes.dart';

class ProductShow extends StatefulWidget {
  const ProductShow({Key? key}) : super(key: key);

  @override
  _ProductShowState createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {


  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('product_home');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              child: Column(
                
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
                                    Get.to(ProductDetailes( ));
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 120,

                                            child: Image.network(documentSnapshot['img1'])),

                                        Text("${documentSnapshot['name']}",
                                          style: TextStyle(),),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("${documentSnapshot['price'].toString()} \$",
                                            style: TextStyle(color: Colors.redAccent),
                                          textAlign: TextAlign.start,),
                                        ),
                                        //Text(" ${documentSnapshot['discount']} %"),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Sku ${documentSnapshot['sku']}")),
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
          ],
        ),
      ),
    );
  }
}
