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
  final bool isFlag;
  const SamplePagePerson({Key? key, required this.name, required this.isFlag});

  @override
  State<SamplePagePerson> createState() => _SamplePagePersonState(name, isFlag);
}

List<Protocol> persons = [
  Protocol(name: 'José', protolSample: '25 anos', isSelected: false),
  Protocol(name: 'João', protolSample: 'Alguma observação', isSelected: false),
  Protocol(name: 'Carlos ', protolSample: 'notes', isSelected: false),
  Protocol(name: 'Paulo ', protolSample: '----', isSelected: false),
  Protocol(name: 'Luís ', protolSample: '-----', isSelected: false),
  Protocol(name: 'Pedro ', protolSample: '----', isSelected: false),
  Protocol(name: 'Marcos ', protolSample: '----', isSelected: false),
  Protocol(name: 'Rafael ', protolSample: '-----', isSelected: false),
  Protocol(name: 'Daniel ', protolSample: '----', isSelected: false),
];

List<Protocol> personsByProtocol = [
  Protocol(name: 'José', protolSample: '25 anos', isSelected: true),
  Protocol(name: 'João', protolSample: 'Alguma observação', isSelected: true),
  Protocol(name: 'Carlos ', protolSample: 'notes', isSelected: true),
  Protocol(name: 'Paulo ', protolSample: '----', isSelected: true),
  Protocol(name: 'Luís ', protolSample: '-----', isSelected: true),
];

List<Protocol> myPersons(bool isProtocolSample) {
  if (isProtocolSample) {
    return personsByProtocol;
  } else {
    return persons;
  }
}

class _SamplePagePersonState extends State<SamplePagePerson> {
  final String name;
  final bool isFlag;
  TextEditingController searchController = TextEditingController();
  String filter = "";

  _SamplePagePersonState(this.name, this.isFlag);

  @override
  void initState() {
    super.initState();
    myPersons(isFlag);
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
              child: persons.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          "Nenhuma amostra cadastrado",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(AddSample(
                                sampleAppBar: "Adicionar nova amostra",
                              ));
                            },
                            child: Text("\u{2795} Adicionar amostra"))
                      ],
                    ))
                  : ListView.builder(
                      itemCount: myPersons(isFlag).length,
                      itemBuilder: (context, index) {
                        // if filter is null or empty returns all data
                        return filter == ""
                            ? ListTile(
                                title: Text(
                                  '${myPersons(isFlag)[index].name}',
                                ),
                                subtitle: Text(
                                    '${myPersons(isFlag)[index].protolSample}'),
                                leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                        '${myPersons(isFlag)[index].name.substring(0, 1)}')),
                                trailing: TextButton(
                                  child: myPersons(isFlag)[index].isSelected ==
                                          false
                                      ? Text("Adicionar")
                                      : Text(
                                          "Adicionado",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  onPressed: () {
                                    c.setSampleName(
                                        '${myPersons(isFlag)[index].name}');
                                    setState(() {
                                      myPersons(isFlag).forEach((element) {
                                        if (element.name ==
                                            myPersons(isFlag)[index].name) {
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
                                onTap: () => _onTapItem(
                                    context, myPersons(isFlag)[index]),
                              )
                            : '${myPersons(isFlag)[index].name}'
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? ListTile(
                                    title: Text(
                                      '${myPersons(isFlag)[index].name}',
                                    ),
                                    subtitle: Text(
                                        '${myPersons(isFlag)[index].protolSample}'),
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                            '${myPersons(isFlag)[index].name.substring(0, 1)}')),
                                    trailing: TextButton(
                                      child:
                                          myPersons(isFlag)[index].isSelected ==
                                                  false
                                              ? Text("Adicionar")
                                              : Text(
                                                  "Adicionar",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                      onPressed: () {
                                        c.setSampleName(
                                            '${myPersons(isFlag)[index].name}');
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
                                    onTap: () => _onTapItem(
                                        context, myPersons(isFlag)[index]),
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
