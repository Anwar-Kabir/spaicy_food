import 'package:get/get.dart';
import 'package:spaicy_food/controller/getx_network_controllar.dart';

class Networking extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<getxnetwork>(() => getxnetwork());
  }
}