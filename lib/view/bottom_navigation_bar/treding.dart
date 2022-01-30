import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spaicy_food/view/product/product_show.dart';

class Treding extends StatelessWidget {
  const Treding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [


                Align(
                  alignment: Alignment.center,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: const Text(
                      'Use coupun & get 25% off',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        )

    );
  }
}