import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/category/category_details.dart';
import 'package:spaicy_food/view/product/product_detailes.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final CollectionReference _category =
      FirebaseFirestore.instance.collection('category_home');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: _category.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(CategoryDetailes());
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            child: Image.network(
                                                documentSnapshot['image']),
                                          ),
                                          Text(documentSnapshot['name']),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
