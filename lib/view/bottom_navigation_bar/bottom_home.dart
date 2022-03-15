import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/category/category.dart';
import 'package:spaicy_food/view/chip_home_top/chip_firebase_retrive.dart';
import 'package:spaicy_food/view/chip_home_top/chip_trending.dart';
import 'package:spaicy_food/view/product/product_show.dart';

class BottomHome extends StatefulWidget {
  const BottomHome({Key? key}) : super(key: key);

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  final CarouselController _controller = CarouselController();

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
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: _loadImages(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
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
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Container(
                  height: 80,
                  child: Column(
                    children: [
                      Expanded(child: Category()),
                    ],
                  )),

              /*CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),*/

              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ]),*/

              SizedBox(
                height: MediaQuery.of(context).size.height * .002,
              ),
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
                  height: 210,
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
