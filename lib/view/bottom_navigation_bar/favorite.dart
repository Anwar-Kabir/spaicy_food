import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spaicy_food/view/product/product_show.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width: double.infinity,
            height: 250,
            child: Image.asset(
              "assets/images/empty_wish_list.png",
              height: 250,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 40,
            child: Container(
              color: Color(0xFFFFFFFF),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              "You haven't anything to wish List",
              style: TextStyle(
                color: Color(0xFF67778E),
                fontFamily: 'Roboto-Light.ttf',
                fontSize: 20,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.center,
            ),
          )


        ],
      )



    );
  }
}
