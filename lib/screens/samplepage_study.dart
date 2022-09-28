import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:opentdcsapp/screens/addsamplepage.dart';
import 'package:opentdcsapp/screens/profile.dart';
import 'package:opentdcsapp/screens/samplepage_protocol.dart';

final c = Get.put(ControllerTdcs.to);

class SamplePageStudy extends StatefulWidget {
  const SamplePageStudy({Key? key}) : super(key: key);

  @override
  State<SamplePageStudy> createState() => _SamplePageStudyState();
}

List<Contact> studies = [
  Contact(
      name: 'Parkison',
      protolSample: 'Amostra: 60; Protocolo: 3',
      isSelected: true),
  Contact(
      name: 'Fibromialgia',
      protolSample: 'Amostra: 30; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'AVE ',
      protolSample: 'Amostra: 25; Protocolo: 5',
      isSelected: false),
  Contact(
      name: 'Depressão ',
      protolSample: 'Amostra: 15; Protocolo: 4',
      isSelected: false),
  Contact(
      name: 'Estudo 1',
      protolSample: 'Amostra: 10; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 2',
      protolSample: 'Amostra: 50; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 3',
      protolSample: 'Amostra: 35; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 4',
      protolSample: 'Amostra: 40; Protocolo: 4',
      isSelected: false),
];

List<Contact> studiesview = [
  Contact(
      name: 'Parkison',
      protolSample: 'Amostra: 60; Protocolo: 3',
      isSelected: true),
  Contact(
      name: 'Fibromialgia',
      protolSample: 'Amostra: 30; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'AVE ',
      protolSample: 'Amostra: 25; Protocolo: 5',
      isSelected: false),
  Contact(
      name: 'Depressão ',
      protolSample: 'Amostra: 15; Protocolo: 4',
      isSelected: false),
  Contact(
      name: 'Estudo 1',
      protolSample: 'Amostra: 10; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 2',
      protolSample: 'Amostra: 50; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 3',
      protolSample: 'Amostra: 35; Protocolo: 2',
      isSelected: false),
  Contact(
      name: 'Estudo 4',
      protolSample: 'Amostra: 40; Protocolo: 4',
      isSelected: false),
];

List<Contact> samples = [
  Contact(name: 'José', protolSample: '25 anos', isSelected: false),
  Contact(name: 'João', protolSample: 'Alguma observação', isSelected: false),
  Contact(name: 'Carlos ', protolSample: 'notes', isSelected: false),
  Contact(name: 'Paulo ', protolSample: '----', isSelected: false),
  Contact(name: 'Luís ', protolSample: '-----', isSelected: false),
  Contact(name: 'Pedro ', protolSample: '----', isSelected: false),
  Contact(name: 'Marcos ', protolSample: '----', isSelected: false),
  Contact(name: 'Rafael ', protolSample: '-----', isSelected: false),
  Contact(name: 'Daniel ', protolSample: '----', isSelected: false),
];

class _SamplePageStudyState extends State<SamplePageStudy> {
  TextEditingController searchController = TextEditingController();
  String filter = "";

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Get.to(AddSample(
            sampleAppBar: "Adicionar nova amostra",
          ));
        },
        heroTag: "btn1",
        tooltip: 'Adicionar nova amostra',
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Get.to(AddSample(sampleAppBar: 'Criar novo estudo'));
        },
        heroTag: "btn2",
        tooltip: 'Criar novo estudo',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget float3() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          // Get.to(AddSample(sampleAppBar: 'Amostras'));
          setState(() {
            studies = samples;
          });
        },
        heroTag: "btn3",
        tooltip: 'Vizualizar amostra',
        child: Icon(Icons.person_search),
      ),
    );
  }

  Widget float4() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            studies = studiesview;
          });
        },
        heroTag: "btn4",
        tooltip: 'Vizualizar estudos',
        child: Icon(Icons.school),
      ),
    );
  }

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
              child: studies.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          "Nenhum estudo cadastrado",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(AddSample(
                                sampleAppBar: "Adicionar novo estudo",
                              ));
                            },
                            child: Text("\u{2795} Adicionar novo estudo"))
                      ],
                    ))
                  : ListView.builder(
                      itemCount: studies.length,
                      itemBuilder: (context, index) {
                        // if filter is null or empty returns all data
                        return filter == ""
                            ? ListTile(
                                title: Text(
                                  '${studies[index].name}',
                                ),
                                subtitle:
                                    Text('${studies[index].protolSample}'),
                                leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                        '${studies[index].name.substring(0, 1)}')),
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
                                    _onTapItem(context, studies[index]),
                              )
                            : '${studies[index].name}'
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? ListTile(
                                    title: Text(
                                      '${studies[index].name}',
                                    ),
                                    subtitle:
                                        Text('${studies[index].protolSample}'),
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                            '${studies[index].name.substring(0, 1)}')),
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
                                        _onTapItem(context, studies[index]),
                                  )
                                : Container();
                      },
                    ))
        ],
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          tooltip: "Opções",
          //Fab list
          fabButtons: <Widget>[float1(), float2(), float3(), float4()],
          key: key,
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
    );
  }
}

void _onTapItem(BuildContext context, Contact post) {
  // Scaffold.of(context).showSnackBar(
  //     new SnackBar(content: new Text("Tap on " + ' - ' + post.name)));

  if (studies == samples) {
    Get.to(ProfileSample(name: post.name));
  } else {
    Get.to(SamplePageProtocol(
      name: post.name,
    ));
  }
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
