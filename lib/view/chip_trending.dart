import 'package:flutter/material.dart';

class ChipTrending extends StatefulWidget {
  const ChipTrending({Key? key}) : super(key: key);

  @override
  _ChipTrendingState createState() => _ChipTrendingState();
}

class _ChipTrendingState extends State<ChipTrending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chip Trending"),
      ),
    );
  }
}
