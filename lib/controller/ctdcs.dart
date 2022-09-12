import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/profile.dart';

class ControllerTdcs extends GetxController {
  var current = "- mA".obs;
  var currentReal = 0.0.obs;
  var time = 0.obs;
  var mode = "-".obs;
  var sham = "-".obs;
  var resistence = 0.obs;
  var isPlay = Icons.play_arrow.obs;
  var isStop = Icons.settings.obs;
  var bisPlay = false.obs;
  var bisStop = false.obs;
  var colormA = Colors.red.obs;
  var colorK = Colors.red.obs;
  var nameSample = "Criar novo estudo".obs;
  var cardsinfo = [].obs;

  static ControllerTdcs get to => Get.find<ControllerTdcs>();

  @override
  void onInit() {
    super.onInit();
  }

  setEeg(CardsProfile ls) {
    cardsinfo.value.add(ls);
  }

  setSampleName(String s) {
    nameSample(s);
  }

  setColormA(MaterialColor c) {
    colormA(c);
  }

  setColorK(MaterialColor c) {
    colorK(c);
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

  setResistence(int i) {
    resistence(i);
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
