import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:opentdcsapp/screens/addsamplepage.dart';
import 'package:opentdcsapp/screens/profile.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:opentdcsapp/screens/protocol_create_edit.dart';
import 'package:opentdcsapp/screens/samplepage_persons.dart';

final c = Get.put(ControllerTdcs.to);

final GlobalKey<AnimatedFloatingActionButtonState> key =
    GlobalKey<AnimatedFloatingActionButtonState>();

Widget float1() {
  return Container(
    child: FloatingActionButton(
      onPressed: () {
        Get.to(SamplePagePerson(
          name: "Adicionar amostras no estudo",
          isFlag: true,
        ));
      },
      heroTag: "btn1",
      tooltip: 'Adicionar amostra para o estudo',
      child: Icon(Icons.person_add),
    ),
  );
}

Widget float2() {
  return Container(
    child: FloatingActionButton(
      onPressed: () {
        Get.to(ProtocolPage(
          protocolName: "",
          intensity: "Intensidade",
          duration: "",
          rampUp: "",
          rampDown: "",
          btnRandom: false,
        ));
      },
      heroTag: "btn2",
      tooltip: 'Criar novo protocolo',
      child: Icon(Icons.add),
    ),
  );
}

Widget float3() {
  return Container(
    child: FloatingActionButton(
      onPressed: null,
      heroTag: "btn3",
      tooltip: 'Randomizar amostra',
      child: Icon(Icons.addchart),
    ),
  );
}

class SamplePageProtocol extends StatefulWidget {
  final String name;
  const SamplePageProtocol({Key? key, required this.name});

  @override
  State<SamplePageProtocol> createState() => _SamplePageProtocolState(name);
}

List<Protocol> protocols = [
  Protocol(name: 'Placebo', protolSample: 'Amostra: 5', isSelected: true),
  Protocol(name: 'Ativo 1', protolSample: 'Amostra: 5', isSelected: false),
  Protocol(name: 'Ativo 2 ', protolSample: 'Amostra: 5', isSelected: false),
];

class _SamplePageProtocolState extends State<SamplePageProtocol> {
  final String name;
  TextEditingController searchController = TextEditingController();
  String filter = "";

  _SamplePageProtocolState(this.name);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(name),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar protocolo',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Expanded(
              child: protocols.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          "Nenhum protocolo cadastrado",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(AddSample());
                            },
                            child: Text("\u{2795} Adicionar amostra"))
                      ],
                    ))
                  : ListView.builder(
                      itemCount: protocols.length,
                      itemBuilder: (context, index) {
                        // if filter is null or empty returns all data
                        return filter == ""
                            ? ListTile(
                                title: Text(
                                  '${protocols[index].name}',
                                ),
                                subtitle:
                                    Text('${protocols[index].protolSample}'),
                                leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                        '${protocols[index].name.substring(0, 1)}')),
                                // trailing: TextButton(
                                //   child: contacts[index].isSelected == false
                                //       ? Text("Selecionar")
                                //       : Text(
                                //           "Selecionado",
                                //           style: TextStyle(color: Colors.black),
                                //         ),
                                //   onPressed: () {
                                //     c.setSampleName('${contacts[index].name}');
                                //     setState(() {
                                //       contacts.forEach((element) {
                                //         if (element.name ==
                                //             contacts[index].name) {
                                //           element.isSelected = true;
                                //         } else {
                                //           element.isSelected = false;
                                //         }
                                //       });
                                //     });
                                //   },
                                // ),
                                onTap: () =>
                                    _onTapItem(context, protocols[index]),
                              )
                            : '${protocols[index].name}'
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? ListTile(
                                    title: Text(
                                      '${protocols[index].name}',
                                    ),
                                    subtitle: Text(
                                        '${protocols[index].protolSample}'),
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                            '${protocols[index].name.substring(0, 1)}')),
                                    // trailing: TextButton(
                                    //   child: contacts[index].isSelected == false
                                    //       ? Text("Selecionar")
                                    //       : Text(
                                    //           "Selecionado",
                                    //           style: TextStyle(
                                    //               color: Colors.black),
                                    //         ),
                                    //   onPressed: () {
                                    //     c.setSampleName(
                                    //         '${contacts[index].name}');
                                    //     setState(() {
                                    //       contacts.forEach((element) {
                                    //         if (element.name ==
                                    //             contacts[index].name) {
                                    //           element.isSelected = true;
                                    //         } else {
                                    //           element.isSelected = false;
                                    //         }
                                    //       });
                                    //     });
                                    //   },
                                    // ),
                                    onTap: () =>
                                        _onTapItem(context, protocols[index]),
                                  )
                                : Container();
                      },
                    ))
        ],
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          tooltip: "Opções",
          //Fab list
          fabButtons: <Widget>[float1(), float2(), float3()],
          key: key,
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
    );
  }
}

void _onTapItem(BuildContext context, Protocol post) {
  // Scaffold.of(contextf).showSnackBar(
  //     new SnackBar(content: new Text("Tap on " + ' - ' + post.name)));
  Get.to(ProtocolPage(
    protocolName: post.name,
    intensity: "0.4 mA",
    duration: "60",
    rampUp: "30",
    rampDown: "10",
    btnRandom: true,
  ));
}

class Protocol {
  final String name;
  final String protolSample;
  bool isSelected;

  Protocol(
      {required this.name,
      required this.protolSample,
      required this.isSelected});
}
