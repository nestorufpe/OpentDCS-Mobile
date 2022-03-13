import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../screens/profile.dart';

class ControllerEeg extends GetxController {
  var cardsinfo = [].obs;

  static ControllerEeg get to => Get.find<ControllerEeg>();

  @override
  void onInit() {
    super.onInit();
  }

  setEeg(CardsProfile ls) {
    cardsinfo.value.add(ls);
  }
}
