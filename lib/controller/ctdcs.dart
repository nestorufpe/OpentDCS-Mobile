import 'package:get/get.dart';

class ControllerTdcs extends GetxController {
  var current = "- mA".obs;
  var currentReal = 0.0.obs;
  var time = 0.obs;

  static ControllerTdcs get to => Get.find<ControllerTdcs>();

  @override
  void onInit() {
    super.onInit();
  }

  setCurrent(String v) {
    current(v);
  }

  setCurrentReal(double d) {
    currentReal(d);
  }

  setTime(int i) {
    time(i);
  }
}
