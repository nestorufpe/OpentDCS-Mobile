import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:opentdcsapp/screens/configtdcs.dart';
import 'package:opentdcsapp/screens/eegresults.dart';
import 'package:opentdcsapp/ui/seek.dart';
import 'package:opentdcsapp/utils/custom_icons.dart';

import '../screens/eegpage.dart';

Widget CircleButton(BuildContext context) {
  return Center(
    child: NeumorphicButton(
      onPressed: () {
        Get.to(ConfigTdcs(), transition: Transition.rightToLeft);
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.settings,
          color: Colors.black,
          size: 44,
        ),
      ),
    ),
  );
}

Widget CircleButtonRts(BuildContext context, Function()? function) {
  return Center(
    child: NeumorphicButton(
      onPressed: function,
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          MdiIcons.reload,
          color: Colors.black,
          size: 24,
        ),
      ),
    ),
  );
}

Widget CircleBtnPlay(BuildContext context) {
  return Center(
    child: NeumorphicButton(
      onPressed: () {
        print("click");
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.play_arrow,
          color: Colors.black,
          size: 44,
        ),
      ),
    ),
  );
}

Widget CircleBtnPlayEeg(BuildContext context, double progress, Timer? timer) {
  return Center(
    child: NeumorphicButton(
      onPressed: () async {
        final text = await showTextInputDialog(
          context: context,
          cancelLabel: "CANCELAR",
          okLabel: "GRAVAR",
          textFields: const [
            DialogTextField(
              hintText: 'Duração em minutos',
              keyboardType: TextInputType.number,
              suffixText: " min",
            ),
          ],
          title: 'Duração',
        );

        // int duration = int.parse(text?.first ?? '0');

        progress = 0;
        timer?.cancel();
        timer =
            await Timer.periodic(Duration(milliseconds: 100), (Timer mtimer) {
          EasyLoading.showProgress(progress,
              maskType: EasyLoadingMaskType.black,
              status: '${(progress * 100).toStringAsFixed(0)}%');
          progress += 0.03;

          if (progress >= 1) {
            timer?.cancel();
            EasyLoading.dismiss();
            text == "0";
            Get.to(EegResults(visible: true,));
          }
        });
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.play_arrow,
          color: Colors.black,
          size: 44,
        ),
      ),
    ),
  );
}

Widget ContainerNeu(BuildContext context) {
  return Neumorphic(
    style: NeumorphicStyle(
      color: Colors.white,
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.circle(),
    ),
    padding: EdgeInsets.all(12.0),
    child: CustomSeek(context),
  );
}

Widget ContainerNeuValues(BuildContext context) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Neumorphic(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 8),
          style: NeumorphicStyle(
            color: Colors.white,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(12))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "I",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "2mA",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: Colors.green,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Neumorphic(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 8),
          style: NeumorphicStyle(
            color: Colors.white,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(12))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "R",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "9 kΩ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: Colors.red,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Neumorphic(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 8),
          style: NeumorphicStyle(
            color: Colors.white,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(12))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Sham",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "B",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    MdiIcons.humanWhiteCane,
                    size: 12,
                    color: Colors.black,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
