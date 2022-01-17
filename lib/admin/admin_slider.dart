import 'package:flutter/material.dart';

class AdminSlider extends StatefulWidget {
  const AdminSlider({Key? key}) : super(key: key);

  @override
  _AdminSliderState createState() => _AdminSliderState();
}

class _AdminSliderState extends State<AdminSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashbord"),
      ),
      body: const Text("Slider"),
    );
  }
}
