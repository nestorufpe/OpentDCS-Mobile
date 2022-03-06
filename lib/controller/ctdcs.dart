import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerTdcs extends GetxController {
  var current = "- mA".obs;
  var currentReal = 0.0.obs;
  var time = 0.obs;
  var mode = "-".obs;
  var sham = "-".obs;
  var isPlay = Icons.play_arrow.obs;
  var isStop = Icons.settings.obs;
  var bisPlay = false.obs;
  var bisStop = false.obs;

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

  setMode(String s) {
    mode(s);
  }

  setSham(String s) {
    sham(s);
  }

  setPlay(IconData s) {
    isPlay(s);
  }

  setIsPlay(bool b) {
    bisPlay(b);
  }

  setStop(IconData s) {
    isStop(s);
  }

  setIsStop(bool b) {
    bisStop(b);
  }
}
