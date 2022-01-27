import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class getxnetwork extends GetxController {

  int connectionType = 0;

  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetConnectionType();
  }

  Future <void> GetConnectionType() async{
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());

    } on PlatformException catch(e){
      print(e);
    }
    return _updateState(connectivityResult);
  }

  _updateState (ConnectivityResult result)
  {
     switch(result)
     {
      case  ConnectivityResult.wifi:
        connectionType=1;
        update();
        break;

       case  ConnectivityResult.mobile:
         connectionType=1;
         update();
         break;

       case  ConnectivityResult.none:
         connectionType=1;
         update();
         break;
       default: Get.snackbar("Network Error", "please connect the device with internet");
     }

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }




}

