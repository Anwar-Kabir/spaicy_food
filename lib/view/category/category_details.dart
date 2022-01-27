import 'package:flutter/material.dart';

class CategoryDetailes extends StatefulWidget {
  const CategoryDetailes({Key? key}) : super(key: key);

  @override
  _CategoryDetailesState createState() => _CategoryDetailesState();
}

class _CategoryDetailesState extends State<CategoryDetailes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Details"),
      ),
    );
  }
}
