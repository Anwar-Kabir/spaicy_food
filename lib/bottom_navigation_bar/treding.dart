import 'package:flutter/material.dart';

class Treding extends StatelessWidget {
  const Treding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:
        Image.network('https://s01.sgp1.cdn.digitaloceanspaces.com/article/136252-kignyajnat-1581312745.jpg',
       height: 300,),

    );
  }
}