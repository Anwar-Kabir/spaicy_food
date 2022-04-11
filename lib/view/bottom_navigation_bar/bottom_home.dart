import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/category/category.dart';
import 'package:spaicy_food/view/chip_home_top/chip_firebase_retrive.dart';
import 'package:spaicy_food/view/chip_home_top/chip_trending.dart';
import 'package:spaicy_food/view/product/product_show.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class BottomHome extends StatefulWidget {
  const BottomHome({Key? key}) : super(key: key);

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
      });
    });

    return files;
  }

  final CollectionReference _category =
      FirebaseFirestore.instance.collection('slider');

  Future<List<Map<String, dynamic>>> _loadcategory() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
      });
    });

    return files;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ChipFirebaseRetrive(),
              /*  Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: _loadImages(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider.builder(
                        slideBuilder: (index) {
                          final Map<String, dynamic> image =
                              snapshot.data![index];
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(image['url']),
                          );
                        },
                        itemCount: snapshot.data!.length,
                        slideTransform: CubeTransform(
                          rotationAngle: 0,
                        ),
                        autoSliderDelay: Duration(seconds: 1),
                        enableAutoSlider: true,
                        slideIndicator: CircularSlideIndicator(
                          indicatorBackgroundColor: Colors.red,
                          currentIndicatorColor: Colors.green,
                        ),
                      );

                      /* return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> image =
                              snapshot.data![index];

                          return Container(
                            // dense: false,
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(image['url']),
                            ),
                          );
                        },
                      ); */
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ), */
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 50,
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: _category.snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return CarouselSlider.builder(
                              slideBuilder: (index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];

                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Image.network(
                                            documentSnapshot['image'])),
                                  ),
                                );
                              },
                              itemCount: streamSnapshot.data!.docs.length,
                              slideTransform: CubeTransform(
                                rotationAngle: 0,
                              ),
                              autoSliderDelay: Duration(seconds: 3),
                              unlimitedMode: true,
                              enableAutoSlider: true,
                              slideIndicator: CircularSlideIndicator(
                                indicatorBackgroundColor: Colors.red,
                                currentIndicatorColor: Colors.green,
                              ),
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 98,
                  child: Column(
                    children: [
                      Expanded(child: Category()),
                    ],
                  )),
              /*  SizedBox(
                height: MediaQuery.of(context).size.height * .022,
              ), */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "You may like",
                    style: TextStyle(
                      // letterSpacing: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)),
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  height: 220,
                  child: Column(
                    children: [
                      Expanded(child: ProductShow()),
                    ],
                  )),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
