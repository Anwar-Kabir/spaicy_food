import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BottomHome extends StatefulWidget {
  const BottomHome({Key? key}) : super(key: key);

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {

  Future getsliderfromfirebase () async{
    var collection = FirebaseFirestore.instance.collection('slider');
    var docSnapshot = await collection.doc('doc_id').get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['image']; // <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }



  final imageData = [
    'assets/images/slider/slider.png',
    'assets/images/slider/slider.png',
    'assets/images/slider/slider.png',
    'assets/images/slider/slider.png',
    'assets/images/slider/slider.png'
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();
  final imgList = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Padding(padding: EdgeInsets.all(16.0),),
          //CarouselSlider(items: items, options: options)



         /* FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: collection.doc('doc_id').get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text ('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                var data = snapshot.data!.data();
                var value = data!['image']; // <-- Your value
                return Text('Value = $value');
              }

              return Center(child: CircularProgressIndicator());
            },
          ),*/



          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 100.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/slider/slider.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
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

          // Category(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
