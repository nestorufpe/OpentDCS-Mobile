import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/controller/ceeg.dart';
import 'package:opentdcsapp/screens/eegresults.dart';

final ce = Get.put(ControllerEeg());

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
      type: "Intensidade:  ",
      typeValue: "2 mA",
      time: "Tempo: ",
      timeValue: "20 min",
      shamElectrodes: "Modo placebo: ",
      shamElectrodesValue: "B (ECA Parkison)",
      textBtn: "Ver Placebo",
    ),
    CardsProfile(
      trial: "EEG",
      type: "Tempo:  ",
      typeValue: "5 min",
      time: "Período: ",
      timeValue: "Antes da tDCS",
      shamElectrodes: "Eletrodos: ",
      shamElectrodesValue: "F7, FC5, FC3, Fp1, AFz, Fp2, FC4, FC6",
      textBtn: "Ver Gráfico",
    )
  ];

  _ProfileSampleState(this.name);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "ECA Parkison",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 18,
            ),
            Divider(
              height: 8,
              color: Colors.black12,
              thickness: 8,
              indent: 8,
              endIndent: 8,
            ),
            SizedBox(
              height: 9,
            ),
            Text(
              "Histórico",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 9,
            ),
            Obx(() => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ce.cardsinfo.isEmpty
                      ? Text("Nenhuma coleta feita ainda")
                      : ListView.builder(
                          itemCount: ce.cardsinfo.length,
                          itemBuilder: (context, index) {
                            return ce.cardsinfo[index];
                          }),
                ))
          ],
        ),
      ),
    );
  }
}

class CardsProfile extends StatelessWidget {
  final String trial;
  final String type;
  final String typeValue;
  final String time;
  final String timeValue;
  final String shamElectrodes;
  final String shamElectrodesValue;
  final String textBtn;

  const CardsProfile(
      {Key? key,
      required this.trial,
      required this.type,
      required this.typeValue,
      required this.time,
      required this.timeValue,
      required this.shamElectrodes,
      required this.shamElectrodesValue,
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
                            text: type,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black38)),
                        TextSpan(
                            text: typeValue,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black))
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
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black))
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
                            text: shamElectrodes,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black38)),
                        TextSpan(
                            text: shamElectrodesValue,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black))
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
                        if (trial == "tDCS") {
                          final result = await showOkAlertDialog(
                            context: context,
                            title: "Modo Placebo",
                            message: "A: Sham\nB: Ativo",
                          );
                        } else {
                          Get.to(EegResults(
                            visible: false,
                          ));
                        }
                      },
                      child: Text(textBtn),
                    ),
                    TextButton(
                        onPressed: () {
                          ce.cardsinfo.removeLast();
                        },
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
