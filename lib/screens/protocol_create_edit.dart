import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

Widget SelectIntensity(BuildContext context, String intensity) {
  return DropdownSearch<String>(
    items: ["0.1 mA", "0.2 mA", "0.3 mA", "0.4 mA", "Placebo (desligado)"],
    dropdownSearchDecoration: InputDecoration(
        // labelText: "Meus estudos",
        // hintText: "country in menu mode",
        ),
    onChanged: print,
    selectedItem: intensity == "" ? "Intensidade / Placebo" : intensity,
  );
}

class ProtocolPage extends StatelessWidget {
  final String protocolName;
  final String intensity;
  final String duration;
  final String rampUp;
  final String rampDown;

  const ProtocolPage(
      {Key? key,
      required this.protocolName,
      required this.intensity,
      required this.duration,
      required this.rampUp,
      required this.rampDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var protocolNameCtlr = TextEditingController();
    var durationCtlr = TextEditingController();
    var rampUpCtlr = TextEditingController();
    var rampDownCtrl = TextEditingController();
    protocolNameCtlr.text = protocolName;
    durationCtlr.text = duration;
    rampUpCtlr.text = rampUp;
    rampDownCtrl.text = rampDown;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Novo protocolo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: TextField(
                controller: protocolNameCtlr,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome do protocolo',
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: SelectIntensity(context, intensity)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: TextField(
                controller: durationCtlr,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Duração (segundos)',
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: TextField(
                controller: rampUpCtlr,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Rampa de subida (segundos)',
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: TextField(
                controller: rampDownCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Rampa de descida (segundos)',
                ),
              )),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'SALVAR PROTOCOLO',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
