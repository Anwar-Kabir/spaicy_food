import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:spaicy_food/view/internet_check_getx/test/internet_connection_cheeck.dart';

class InternetCheck extends StatefulWidget {
  const InternetCheck({Key? key}) : super(key: key);

  @override
  _InternetCheckState createState() => _InternetCheckState();
}

class _InternetCheckState extends State<InternetCheck> {

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        string = 'Mobile: Online';
        break;
      case ConnectivityResult.wifi:
        string = 'WiFi: Online';
        break;
      case ConnectivityResult.none:
      default:
        string = 'Offline';
    }

    return Scaffold(
      body: Center(child:

      Text(string)),
    );
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}