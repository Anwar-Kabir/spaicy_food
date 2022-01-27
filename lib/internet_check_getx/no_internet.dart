import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NOInternet extends StatelessWidget {
  const NOInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarBrightness: Brightness.dark, // as you need dark or light
    ));

    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Image.asset(
              'assets/images/nointernet.png',
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .3,
            )),
          ),
          const Text(
            "No Internet!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Please Turn on your Internet Connection.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      )),
    );
  }
}
