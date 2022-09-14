import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:opentdcsapp/screens/addsamplepage.dart';
import 'package:opentdcsapp/screens/profile.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:opentdcsapp/screens/protocol_create_edit.dart';

final c = Get.put(ControllerTdcs.to);

final GlobalKey<AnimatedFloatingActionButtonState> key =
    GlobalKey<AnimatedFloatingActionButtonState>();

class SamplePagePerson extends StatefulWidget {
  final String name;
  const SamplePagePerson({Key? key, required this.name});

  @override
  State<SamplePagePerson> createState() => _SamplePagePersonState(name);
}

List<Protocol> protocols = [
  Protocol(name: 'José', protolSample: '25 anos', isSelected: true),
  Protocol(name: 'João', protolSample: 'Alguma observação', isSelected: false),
  Protocol(name: 'Carlos ', protolSample: 'notes', isSelected: false),
  Protocol(name: 'Paulo ', protolSample: '----', isSelected: false),
  Protocol(name: 'Luís ', protolSample: '-----', isSelected: false),
  Protocol(name: 'Pedro ', protolSample: '----', isSelected: false),
  Protocol(name: 'Marcos ', protolSample: '----', isSelected: false),
  Protocol(name: 'Rafael ', protolSample: '-----', isSelected: false),
  Protocol(name: 'Daniel ', protolSample: '----', isSelected: false),
];

class _SamplePagePersonState extends State<SamplePagePerson> {
  final String name;
  TextEditingController searchController = TextEditingController();
  String filter = "";

  _SamplePagePersonState(this.name);

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
                hintText: 'Buscar amostra',
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
                                trailing: TextButton(
                                  child: protocols[index].isSelected == false
                                      ? Text("Selecionar")
                                      : Text(
                                          "Selecionado",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  onPressed: () {
                                    c.setSampleName('${protocols[index].name}');
                                    setState(() {
                                      protocols.forEach((element) {
                                        if (element.name ==
                                            protocols[index].name) {
                                          if (element.isSelected == true) {
                                            element.isSelected = false;
                                          } else {
                                            element.isSelected = true;
                                          }
                                        }
                                      });
                                    });
                                  },
                                ),
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
                                    trailing: TextButton(
                                      child:
                                          protocols[index].isSelected == false
                                              ? Text("Selecionar")
                                              : Text(
                                                  "Selecionado",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                      onPressed: () {
                                        c.setSampleName(
                                            '${protocols[index].name}');
                                        // setState(() {
                                        //   protocols.forEach((element) {
                                        //     if (element.name ==
                                        //         protocols[index].name) {
                                        //       element.isSelected = true;
                                        //     } else {
                                        //       element.isSelected = false;
                                        //     }
                                        //   });
                                        // });
                                      },
                                    ),
                                    onTap: () =>
                                        _onTapItem(context, protocols[index]),
                                  )
                                : Container();
                      },
                    ))
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
                'CRIAR NOVA AMOSTRA',
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

void _onTapItem(BuildContext context, Protocol post) {
  // Scaffold.of(contextf).showSnackBar(
  //     new SnackBar(content: new Text("Tap on " + ' - ' + post.name)));
  // Get.to(ProtocolPage(
  //     protocolName: post.name,
  //     intensity: "0.4 mA",
  //     duration: "60",
  //     rampUp: "30",
  //     rampDown: "10"));
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
