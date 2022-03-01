import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:opentdcsapp/ui/widgets.dart';
import 'package:opentdcsapp/ui/neu_digital_clock.dart';

class TDCSPage extends StatelessWidget {
  TDCSPage({Key? key}) : super(key: key);

  final c = Get.put(ControllerTdcs());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: NeuDigitalClock(),
                    )),
                Expanded(
                    flex: 1,
                    child: Align(
                      child: CircleButton(context),
                      alignment: Alignment.center,
                    )),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: ContainerNeu(context),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Obx(() => Expanded(
                    flex: 2,
                    child: ContainerNeuValues(context,
                        c.currentReal.value.toString().substring(0, 3)))),
                Expanded(flex: 1, child: CircleBtnPlay(context))
              ],
            ),
          )
        ],
      )),
    );
  }
}
