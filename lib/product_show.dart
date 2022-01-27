import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 120,
                                         // width: 110,
                                          child: Image.network(documentSnapshot['img1'])),

                                      Text(documentSnapshot['name']),
                                      Text("${documentSnapshot['price'].toString()} \$"),
                                      Text("Sku ${documentSnapshot['sku']}"),
                                    ],
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
