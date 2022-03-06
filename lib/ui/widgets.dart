import 'dart:async';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:opentdcsapp/screens/configtdcs.dart';
import 'package:opentdcsapp/screens/eegresults.dart';
import 'package:opentdcsapp/ui/seek.dart';
import 'package:opentdcsapp/utils/custom_icons.dart';
import 'package:pausable_timer/pausable_timer.dart';

import '../screens/eegpage.dart';

final c = Get.put(ControllerTdcs.to);

Widget CircleButtonConfig(BuildContext context) {
  return Center(
    child: NeumorphicButton(
      onPressed: () {
        Get.to(ConfigTdcs(), transition: Transition.rightToLeft);

        c.setIsStop(true);
        c.setPlay(Icons.play_arrow);
        c.setCurrentReal(0.0);
        c.setTime(0);
        c.setStop(Icons.settings);
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          c.isStop.value,
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

void playCurrent(double start_intensity, double stop_intensity) {
  late final PausableTimer timer;
  timer = PausableTimer(
    Duration(seconds: 1),
    () {
      start_intensity = start_intensity <= stop_intensity
          ? start_intensity += 0.1
          : start_intensity;

      if (start_intensity <= stop_intensity) {
        timer
          ..reset()
          ..start();
      }
      // This is really what your callback do.
      print('\t$start_intensity');

      c.setCurrentReal(start_intensity);
    },
  )..start();
}

void playTime(int start_tempo, int stop_time) {
  late final PausableTimer timer;
  timer = PausableTimer(
    Duration(seconds: 1),
    () {
      start_tempo = start_tempo >= stop_time ? start_tempo -= 1 : start_tempo;

      if (start_tempo >= stop_time) {
        timer
          ..reset()
          ..start();
      } else {
        c.setCurrentReal(0.0);
        c.setPlay(Icons.play_arrow);
      }

      if (c.bisPlay == false) {
        timer.pause();
      }

      if (c.bisStop == true) {
        timer.cancel();
        c.setTime(0);
      }
      // This is really what your callback do.
      print('\t$start_tempo');
      c.setTime(start_tempo);
    },
  )..start();
}

Widget CircleBtnPlay(BuildContext context) {
  return Center(
    child: NeumorphicButton(
      onPressed: () async {
        double stop_intensity = double.parse(c.current.value.substring(0, 3));
        int start_tempo = c.time.value;
        int stop_time = 1;
        double start_intensity = 0;

        c.bisPlay == true ? c.setIsPlay(false) : c.setIsPlay(true);

        if (c.bisPlay == true) {
          c.setPlay(Icons.pause);
          playCurrent(start_intensity, stop_intensity);
          playTime(start_tempo, stop_time);
          c.setStop(Icons.stop);
          c.setIsStop(false);
        } else {
          c.setPlay(Icons.play_arrow);
          playTime(start_tempo, stop_time);
        }
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          c.isPlay.value,
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
            Get.to(EegResults(
              visible: true,
            ));
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
    child: Obx(() => CustomSeek(context, c.currentReal.value)),
  );
}

Widget ContainerNeuValues(BuildContext context, String current) {
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
                    current,
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
                    c.sham.value == "NÃO" ? "NÃO" : c.mode.value,
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

int random(min, max) {
  return min + Random().nextInt(max - min);
}
