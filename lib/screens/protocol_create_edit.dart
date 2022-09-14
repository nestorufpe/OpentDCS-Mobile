import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_search/dropdown_search.dart';

Widget SelectStudy(BuildContext context) {
  return DropdownSearch<String>(
    items: ["0.1 mA", "0.2 mA", "0.3 mA", "0.4 mA", "Placebo"],
    dropdownSearchDecoration: InputDecoration(
        // labelText: "Meus estudos",
        // hintText: "country in menu mode",
        ),
    onChanged: print,
    selectedItem: "Intensidade / Placebo",
  );
}

class ProtocolPage extends StatelessWidget {
  const ProtocolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nome do protocolo',
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: SelectStudy(context)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Duração (segundos)',
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Rampa de subida (segundos)',
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Rampa de descida (segundos)',
                ),
              )),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () {
            //print('called on tap');
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
