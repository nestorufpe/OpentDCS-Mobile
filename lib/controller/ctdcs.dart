import 'package:get/get.dart';

class ControllerTdcs extends GetxController {
  var current = "0 mA".obs;

static ControllerTdcs get to => Get.find<ControllerTdcs>();

 @override
 void onInit(){
   super.onInit();
 }

  setCurrent (String v){
    current(v);
  }
}