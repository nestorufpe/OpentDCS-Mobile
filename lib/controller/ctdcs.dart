import 'package:get/get.dart';

class ControllerTdcs extends GetxController {
  var current = "- mA".obs;
  var currentReal = 0.0.obs;

  static ControllerTdcs get to => Get.find<ControllerTdcs>();

  @override
  void onInit() {
    super.onInit();
  }

  setCurrent(String v) {
    current(v);
  }

  setCurrentReal(double i) {
    currentReal(i);
  }
}
