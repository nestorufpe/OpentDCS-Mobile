import 'package:get/get.dart';
import 'package:opentdcsapp/screens/configtdcs.dart';

import '../controller/ctdcs.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ControllerTdcs>(ControllerTdcs());
  }
}
