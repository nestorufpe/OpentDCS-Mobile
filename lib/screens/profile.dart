import 'dart:html';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/screens/eegresults.dart';

class ProfileSample extends StatefulWidget {
  final String name;

  const ProfileSample({Key? key, required this.name});

  @override
  State<ProfileSample> createState() => _ProfileSampleState(name);
}

class _ProfileSampleState extends State<ProfileSample> {
  List<String> data = ["1", "2", "3", "4"];
  final String name;

  List<CardsProfile> cardsInfo = [
    CardsProfile(
      trial: "tDCS",
      intensity: "Intensidade:  ",
      intensityValue: "2 mA",
      time: "Tempo: ",
      timeValue: "20 min",
      sham: "Modo placebo: ",
      shamValue: "B (ECA Parkison)",
      textBtn: "Ver Placebo",
    ),
    CardsProfile(
      trial: "EEG",
      intensity: "Tempo:  ",
      intensityValue: "5 min",
      time: "Período: ",
      timeValue: "Antes da tDCS",
      sham: "Eletrodos: ",
      shamValue: "F7, FC5, FC3, Fp1, AFz, Fp2, FC4, FC6",
      textBtn: "Ver Gráfico",
    )
  ];

  _ProfileSampleState(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Neumorphic(
              child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.12,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "${name.substring(0, 1)}",
                    style: TextStyle(fontSize: 24),
                  )),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: Colors.white),
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 17),
          ),
          Text(
            "ECA Parkison",
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Histórico",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 9,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
                itemCount: cardsInfo.length,
                itemBuilder: (context, index) {
                  return cardsInfo[index];
                }),
          )
        ],
      ),
    );
  }
}

class CardsProfile extends StatelessWidget {
  final String trial;
  final String intensity;
  final String intensityValue;
  final String time;
  final String timeValue;
  final String sham;
  final String shamValue;
  final String textBtn;

  const CardsProfile(
      {Key? key,
      required this.trial,
      required this.intensity,
      required this.intensityValue,
      required this.time,
      required this.timeValue,
      required this.sham,
      required this.shamValue,
      required this.textBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(trial,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("25-02-2022",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black38)),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: intensity,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black38)),
                        TextSpan(
                            text: intensityValue,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black38)),
                        TextSpan(
                            text: timeValue,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: sham,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black38)),
                        TextSpan(
                            text: shamValue,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        if (trial=="tDCS") {
                          final result = await showOkAlertDialog(
                            context: context,
                            title: "Modo Placebo",
                            message: "A: Sham\nB: Ativo",
                            
                            );
                        } else {
                          Get.to(EegResults(visible: false,));
                        }
                        
                      },
                      child: Text(textBtn),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Apagar",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              color: Colors.white)),
    );
  }
}
