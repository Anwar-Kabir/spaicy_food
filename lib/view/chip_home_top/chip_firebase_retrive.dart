import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/chip_home_top/chip_trending.dart';

class ChipFirebaseRetrive extends StatefulWidget {
  const ChipFirebaseRetrive({Key? key}) : super(key: key);

  @override
  _ChipFirebaseRetriveState createState() => _ChipFirebaseRetriveState();
}

class _ChipFirebaseRetriveState extends State<ChipFirebaseRetrive> {
  final CollectionReference _chipfirebase =
      FirebaseFirestore.instance.collection('chip_treading');

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: _chipfirebase.snapshots(),
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
                                  Column(
                                    children: [
                                      // Text(documentSnapshot['name']),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ChoiceChip(
                                          selected: _selectedIndex == index,
                                          label: Text(documentSnapshot['name']),
                                          onSelected: (selected) {
                                            if (selected) {
                                              setState(() {
                                                _selectedIndex = index;
                                                Get.to(ChipTrending());
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
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
