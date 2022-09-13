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
import 'package:dropdown_search/dropdown_search.dart';

import '../screens/eegpage.dart';
import '../screens/profile.dart';
import '../screens/tdcspage.dart';

final c = Get.find<ControllerTdcs>();

Widget SelectStudy(BuildContext context) {
  return DropdownSearch<String>(
    items: ["ECA cefaleia", "Low back pain", "Depressão", "Parkison"],
    dropdownSearchDecoration: InputDecoration(
      labelText: "Meus estudos",
      // hintText: "country in menu mode",
    ),
    onChanged: print,
    selectedItem: "ECA cefaleia",
  );
}

Widget SelectSample(BuildContext context) {
  return DropdownSearch<String>(
    items: ["José", "João", "Carlos", "Paulo", "Luiz", "Marcos", "Rafael"],
    dropdownSearchDecoration: InputDecoration(
      labelText: "Participantes do estudo",
      // hintText: "country in menu mode",
    ),
    onChanged: print,
    selectedItem: "José",
  );
}

Widget CircleButtonConfig(BuildContext context) {
  return Center(
    child: NeumorphicButton(
      onPressed: () {
        c.setIsStop(true);
        c.setPlay(Icons.play_arrow);
        c.setCurrentReal(0.0);
        c.setTime(0);
        c.setStop(Icons.settings);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Selecione o estudo'),
                content: SelectStudy(context),
                actions: [
                  FlatButton(
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('CANCELAR'),
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Selecione a amostra'),
                              content: SelectSample(context),
                              actions: [
                                FlatButton(
                                  textColor: Colors.blue,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('CANCELAR'),
                                ),
                                FlatButton(
                                  textColor: Colors.blue,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    c.setCurrent("0.4mA");
                                    c.setCurrentReal(0.0);
                                    c.setTime(10);
                                    c.setMode("m");
                                    c.setSham("s");
                                  },
                                  child: Text('CONCLUIR'),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text('AVANÇAR'),
                  ),
                ],
              );
            });
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
    Duration(milliseconds: 500),
    () {
      start_intensity = start_intensity <= stop_intensity
          ? start_intensity += 0.1
          : start_intensity;

      if (start_intensity <= stop_intensity) {
        timer
          ..reset()
          ..start();
        c.setColormA(Colors.red);
      }
      //stop
      else {
        c.setColormA(Colors.green);
      }
      // This is really what your callback do.
      print('\t$start_intensity');

      c.setCurrentReal(start_intensity);
    },
  )..start();
}

void playTime(int start_tempo, int stop_time, BuildContext context) {
  late final PausableTimer timer;
  timer = PausableTimer(
    Duration(seconds: 2),
    () async {
      start_tempo = start_tempo >= stop_time ? start_tempo -= 1 : start_tempo;

      //atualiza
      if (start_tempo >= stop_time) {
        timer
          ..reset()
          ..start();
      }
      //stop
      else {
        c.setCurrentReal(0.0);
        c.setPlay(Icons.play_arrow);
        c.setStop(Icons.settings);
        c.setResistence(0);
        c.setColormA(Colors.red);
        c.setColorK(Colors.red);
        var dialog = await showOkCancelAlertDialog(
            context: context,
            title: 'SALVAR',
            message: 'Deseja salvar a coleta?',
            barrierDismissible: false,
            okLabel: "SIM",
            cancelLabel: "NÃO");
        if (dialog == OkCancelResult.ok) {
          c.setEeg(
            CardsProfile(
              trial: "tDCS",
              type: "Intensidade:  ",
              typeValue: "2 mA",
              time: "Tempo: ",
              timeValue: "20 min",
              shamElectrodes: "Modo placebo: ",
              shamElectrodesValue: "B (ECA Parkison)",
              textBtn: "Ver Placebo",
            ),
          );
        } else {
          print("cancel");
        }
      }

      if (c.bisPlay.value == false) {
        timer.pause();
        c.setCurrentReal(0.0);
      }

      if (c.bisStop.value == true) {
        timer.cancel();
        c.setTime(0);
      }
      // This is really what your callback do.
      print('\t$start_tempo');
      c.setTime(start_tempo);
    },
  )..start();
}

void playResistence(int start_r, int stop_r) {
  late final PausableTimer timer;
  timer = PausableTimer(
    Duration(milliseconds: 400),
    () {
      start_r = start_r >= stop_r ? start_r -= 1 : start_r;

      //atualiza
      if (start_r >= stop_r) {
        timer
          ..reset()
          ..start();
        c.setColorK(Colors.red);
      }
      //stop
      else {
        c.setColorK(Colors.green);
      }
      if (c.bisStop.value == true) {
        timer.cancel();
        c.setResistence(0);
      }
      // This is really what your callback do.
      print('\t$start_r');
      c.setResistence(start_r);
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
        int start_r = 35;
        int stop_r = 6;

        c.bisPlay == true ? c.setIsPlay(false) : c.setIsPlay(true);

        if (c.bisPlay == true) {
          c.setPlay(Icons.pause);
          playCurrent(start_intensity, stop_intensity);
          playTime(start_tempo, stop_time, context);
          playResistence(start_r, stop_r);
          c.setStop(Icons.stop);
          c.setIsStop(false);
        } else {
          c.setPlay(Icons.play_arrow);
          playTime(start_tempo, stop_time, context);
        }
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() => Icon(
              c.isPlay.value,
              color: Colors.black,
              size: 44,
            )),
      ),
    ),
  );
}

void playProgresEeg(double progress, Timer? timer, List<String>? text) async {
  progress = 0;
  timer?.cancel();
  timer = await Timer.periodic(Duration(milliseconds: 100), (Timer mtimer) {
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
}

Widget CircleBtnPlayEeg(BuildContext context, double progress, Timer? timer) {
  return Center(
    child: NeumorphicButton(
      onPressed: () async {
        final text = await showTextInputDialog(
          context: context,
          cancelLabel: "CANCELAR",
          okLabel: "GRAVAR",
          textFields: [
            DialogTextField(
              hintText: 'Duração em minutos',
              validator: (value) =>
                  value!.isEmpty ? 'Digite o tempo para prosseguir' : null,
              keyboardType: TextInputType.number,
              suffixText: " min",
            ),
            DialogTextField(
              hintText: 'Eletrodos',
              keyboardType: TextInputType.text,
            ),
            DialogTextField(
              hintText: 'Período (antes ou depois da tDCs)',
              keyboardType: TextInputType.text,
            ),
          ],
          title: 'Parâmetros para EEG',
        );
        if (text != null) {
          playProgresEeg(progress, timer, text);
        }
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
                    "mA(REAL)",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        c.currentReal.value <= 0.1
                            ? c.currentReal.value.toString().substring(0, 1)
                            : c.currentReal.value.toString().substring(0, 3),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Icon(
                        Icons.circle,
                        size: 12,
                        color: c.colormA.value,
                      ))
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
                    "kΩ",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Text(
                        "${c.resistence.value}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Icon(
                        Icons.circle,
                        size: 12,
                        color: c.colorK.value,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
      // Expanded(
      //   flex: 1,
      //   child: Neumorphic(
      //     margin: EdgeInsets.symmetric(horizontal: 5),
      //     padding: EdgeInsets.symmetric(vertical: 8),
      //     style: NeumorphicStyle(
      //       color: Colors.white,
      //       shape: NeumorphicShape.flat,
      //       boxShape: NeumorphicBoxShape.roundRect(
      //           BorderRadius.all(Radius.circular(12))),
      //     ),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Column(
      //           children: [
      //             Text(
      //               "Sham",
      //               style: TextStyle(fontSize: 14),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Obx(() => Text(
      //                   c.sham.value == "NÃO" ? "NÃO" : c.mode.value,
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.bold, fontSize: 24),
      //                 )),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Icon(
      //               MdiIcons.humanWhiteCane,
      //               size: 12,
      //               color: Colors.black,
      //             )
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    ],
  );
}

int random(min, max) {
  return min + Random().nextInt(max - min);
}
