import 'package:flutter/material.dart';
import 'package:opentdcsapp/ui/widgets.dart';
import 'package:opentdcsapp/ui/neu_digital_clock.dart';

class TDCSPage extends StatelessWidget {
  const TDCSPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Expanded(
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
            child: Row(
              children: [
                Expanded(flex: 1, child: ContainerNeuValues(context)),
                Expanded(flex: 1, child: CircleBtnPlay(context))
              ],
            ),
          )
        ],
      )),
    );
  }
}
