import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spaicy_food/product_show.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ProductShow()),
        ],
      )



    );
  }
}
