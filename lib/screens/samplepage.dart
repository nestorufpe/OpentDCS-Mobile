import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  State<SamplePage> createState() => _SamplePageState();
}

List<Contact> contacts = [
  Contact(name: 'Fco José', protolSample: 'Parkison'),
  Contact(name: 'Jagadeesh', protolSample: 'Cefaleia'),
  Contact(name: 'Srinivas', protolSample: 'Parkison'),
  Contact(name: 'Narendra', protolSample: 'Parkison'),
  Contact(name: 'Sravan ', protolSample: 'Cefaleia'),
  Contact(name: 'Ranganadh', protolSample: 'Low Back Pain'),
  Contact(name: 'Karthik', protolSample: 'Low Back Pain'),
  Contact(name: 'Saranya', protolSample: 'Memória'),
  Contact(name: 'Mahesh', protolSample: 'Controle Motor'),
];

class _SamplePageState extends State<SamplePage> {
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
                hintText: 'Buscar pelo nome',
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
                          "Nenhuma pessoa cadastrada",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {},
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
  Scaffold.of(context).showSnackBar(
      new SnackBar(content: new Text("Tap on " + ' - ' + post.name)));
}

class Contact {
  final String name;
  final String protolSample;

  const Contact({required this.name, required this.protolSample});
}
