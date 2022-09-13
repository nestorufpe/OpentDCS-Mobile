import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:opentdcsapp/screens/addsamplepage.dart';
import 'package:opentdcsapp/screens/profile.dart';

final c = Get.put(ControllerTdcs.to);

class SamplePageProtocol extends StatefulWidget {
  const SamplePageProtocol({Key? key}) : super(key: key);

  @override
  State<SamplePageProtocol> createState() => _SamplePageProtocolState();
}

List<Contact> contacts = [
  Contact(
      name: 'Parkison',
      protolSample: 'Amostra: 60; Protocolso: 3',
      isSelected: true),
  Contact(
      name: 'Fibromialgia',
      protolSample: 'Amostra: 30; Protocolso: 2',
      isSelected: false),
  Contact(
      name: 'AVE ',
      protolSample: 'Amostra: 25; Protocolso: 5',
      isSelected: false),
  Contact(
      name: 'Depressão ',
      protolSample: 'Amostra: 15; Protocolso: 4',
      isSelected: false),
  Contact(
      name: 'Estudo 1',
      protolSample: 'Amostra: 10; Protocolso: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 2',
      protolSample: 'Amostra: 50; Protocolso: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 3',
      protolSample: 'Amostra: 35; Protocolso: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 4',
      protolSample: 'Amostra: 40; Protocolso: 4',
      isSelected: false),
];

class _SamplePageProtocolState extends State<SamplePageProtocol> {
  TextEditingController searchController = TextEditingController();
  String filter = "";

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar estudo',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Expanded(
              child: contacts.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          "Nenhuma amostra cadastrada",
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
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        // if filter is null or empty returns all data
                        return filter == ""
                            ? ListTile(
                                title: Text(
                                  '${contacts[index].name}',
                                ),
                                subtitle:
                                    Text('${contacts[index].protolSample}'),
                                leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                        '${contacts[index].name.substring(0, 1)}')),
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
                                    _onTapItem(context, contacts[index]),
                              )
                            : '${contacts[index].name}'
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? ListTile(
                                    title: Text(
                                      '${contacts[index].name}',
                                    ),
                                    subtitle:
                                        Text('${contacts[index].protolSample}'),
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                            '${contacts[index].name.substring(0, 1)}')),
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
                                        _onTapItem(context, contacts[index]),
                                  )
                                : Container();
                      },
                    ))
        ],
      ),
    );
  }
}

void _onTapItem(BuildContext context, Contact post) {
  // Scaffold.of(context).showSnackBar(
  //     new SnackBar(content: new Text("Tap on " + ' - ' + post.name)));
  Get.to(ProfileSample(
    name: post.name,
  ));
}

class Contact {
  final String name;
  final String protolSample;
  bool isSelected;

  Contact(
      {required this.name,
      required this.protolSample,
      required this.isSelected});
}
