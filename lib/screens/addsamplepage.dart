import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class AddSample extends StatelessWidget {
  final String sampleAppBar;

  const AddSample({required this.sampleAppBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sampleAppBar)),
      body: Neumorphic(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(10))),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "NOME"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(40),
                      border: OutlineInputBorder(),
                      labelText: "OBSERVAÇÃO"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Salvar"),
                  style: ElevatedButton.styleFrom(fixedSize: Size(240, 40)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
