import 'package:get/get.dart';
import 'package:spaicy_food/internet_check_getx/getx_network_controllar.dart';

class Networking extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<getxnetwork>(() => getxnetwork());
  }
}