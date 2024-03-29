import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:get/get.dart';

class ConfigTdcs extends StatefulWidget {
  const ConfigTdcs({Key? key}) : super(key: key);

  @override
  _ConfigTdcsState createState() => _ConfigTdcsState();
}

List<String> _intensity = [
  "0.5 mA",
  "1.0 mA",
  "1.5 mA",
  "2.0 mA",
];

String _currentv = "";
String _modev = "";
String _shamv = "";
String _protocolv = "";
int _tempov = 0;

class _ConfigTdcsState extends State<ConfigTdcs> {
  List<String> _time = ["10 min", "15 min", "20 min", "30 min", "40 min"];
  List<String> _protocols = [
    "ECA cefaleia",
    "Low back pain",
    "Depressão",
    "Parkison"
  ];
  List<String> _sham = ["NÃO", "SIM"];
  List<String> _mode = ["Modo A", "Modo B"];

  int selectedCurrentsVariants = 0;
  int selectedTimeCounts = 0;
  int selectedSham = 0;
  int selectedProtocol = 0;
  int selectedMode = 0;

  DirectSelectItem<String> getDropDownMenuItemSham(String value) {
    return DirectSelectItem<String>(
      itemHeight: 56,
      value: value,
      itemBuilder: (context, value) {
        _shamv = value;
        return Text(value);
      },
    );
  }

  DirectSelectItem<String> getDropDownMenuItemProtocol(String value) {
    return DirectSelectItem<String>(
      itemHeight: 56,
      value: value,
      itemBuilder: (context, value) {
        _protocolv = value;
        return Text(value);
      },
    );
  }

  DirectSelectItem<String> getDropDownMenuMode(String value) {
    return DirectSelectItem<String>(
      itemHeight: 56,
      value: value,
      itemBuilder: (context, value) {
        _modev = value;
        return Text(value);
      },
    );
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final c = Get.find<ControllerTdcs>();
  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(246, 247, 249, 1),
              border: BorderDirectional(
                  bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 24),
              child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                            "Pressione para ver as opções de configuração para tDCs",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold))),
                    Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text("Configuração",
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))),
                  ])),
        ),
        preferredSize: Size.fromHeight(90));

    return Scaffold(
      appBar: appBar,
      key: scaffoldKey,
      body: DirectSelectContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      IntensitySelector(
                          data: _intensity, label: "Qual a intensidade?"),
                      SizedBox(height: 20.0),
                      TimeSelector(data: _time, label: "Qual a duração?"),
                      SizedBox(height: 15.0),
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          margin: EdgeInsets.only(left: 4),
                          alignment: AlignmentDirectional.centerStart,
                          child: Text("Placebo? (Escolha protocolo e modo)")),
                      Row(children: <Widget>[
                        //Sham
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: _getShadowDecoration(),
                              child: Card(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                          child: DirectSelectList<String>(
                                              onUserTappedListener: () {
                                                _showScaffold();
                                              },
                                              values: _sham,
                                              // defaultItemIndex: selectedSham,
                                              itemBuilder: (String value) =>
                                                  getDropDownMenuItemSham(
                                                      value),
                                              focusedItemDecoration:
                                                  _getDslDecoration(),
                                              onItemSelectedListener:
                                                  (item, index, context) {
                                                // setState(() {
                                                //   selectedSham = index;
                                                // });
                                              }),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8))),
                                ],
                              )),
                            )),
                        //Protocolo
                        Expanded(
                            flex: 2,
                            child: Container(
                              decoration: _getShadowDecoration(),
                              child: Card(
                                  child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                          child: DirectSelectList<String>(
                                              values: _protocols,
                                              onUserTappedListener: () {
                                                _showScaffold();
                                              },
                                              // defaultItemIndex:
                                              //     selectedProtocol,
                                              itemBuilder: (String value) =>
                                                  getDropDownMenuItemProtocol(
                                                      value),
                                              focusedItemDecoration:
                                                  _getDslDecoration(),
                                              onItemSelectedListener:
                                                  (item, index, context) {
                                                // setState(() {
                                                //   selectedProtocol = index;
                                                // });
                                              }),
                                          padding: EdgeInsets.only(left: 22))),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: _getDropdownIcon(),
                                  )
                                ],
                              )),
                            )),
                        //Modo
                        Expanded(
                            flex: 2,
                            child: Container(
                              decoration: _getShadowDecoration(),
                              child: Card(
                                  child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                          child: DirectSelectList<String>(
                                              values: _mode,
                                              onUserTappedListener: () {
                                                _showScaffold();
                                              },
                                              // defaultItemIndex: selectedMode,
                                              itemBuilder: (String value) =>
                                                  getDropDownMenuMode(value),
                                              focusedItemDecoration:
                                                  _getDslDecoration(),
                                              onItemSelectedListener:
                                                  (item, index, context) {
                                                // setState(() {
                                                //   selectedMode = index;
                                                // });
                                              }),
                                          padding: EdgeInsets.only(left: 22))),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: _getDropdownIcon(),
                                  )
                                ],
                              )),
                            )),
                      ]),
                      SizedBox(
                        height: 12,
                      ),
                      Column(children: <Widget>[
                        // RaisedButton(
                        //   child: const Text('\u{2795} NOVO PROTOCOLO SHAM',
                        //       style: TextStyle(color: Colors.blueAccent)),
                        //   onPressed: () async {
                        //     final text = await showTextInputDialog(
                        //       context: context,
                        //       cancelLabel: "CANCELAR",
                        //       textFields: const [
                        //         DialogTextField(
                        //           hintText: 'nome do protocolo',
                        //         ),
                        //       ],
                        //       title: 'Protocolo',
                        //     );
                        //   },
                        // ),
                        ElevatedButton(
                          child: const Text('USAR ESSA CONFIGURAÇÃO',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            c.setCurrent(_currentv);
                            c.setCurrentReal(0.0);
                            c.setTime(_tempov);
                            c.setMode(_modev.substring(5, 6));
                            c.setSham(_shamv);
                            Get.back();
                          },
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showScaffold() {
    // final snackBar =
    //     SnackBar(content: Text('Pressione e segure para ver as opções'));
    // scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Colors.blueAccent,
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(0.0, 0.0),
          blurRadius: 15.0,
        ),
      ],
    );
  }
}

class IntensitySelector extends StatelessWidget {
  final buttonPadding = const EdgeInsets.fromLTRB(0, 8, 0, 0);

  final List<String> data;
  final String label;
  // final c = ControllerTdcs.to;

  IntensitySelector({required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text(label)),
        Padding(
          padding: buttonPadding,
          child: Container(
            decoration: _getShadowDecoration(),
            child: Card(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        child: DirectSelectList<String>(
                          values: data,
                          onUserTappedListener: () {},
                          itemBuilder: (String value) =>
                              getDropDownMenuItemIntensity(value),
                          focusedItemDecoration: _getDslDecoration(),
                        ),
                        padding: EdgeInsets.only(left: 12))),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: _getDropdownIcon(),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  DirectSelectItem<String> getDropDownMenuItemIntensity(String value) {
    return DirectSelectItem<String>(
      itemHeight: 56,
      value: value,
      itemBuilder: (context, value) {
        _currentv = value;
        return Text(value);
      },
    );
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(0.0, 0.0),
          blurRadius: 15.0,
        ),
      ],
    );
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Colors.blueAccent,
    );
  }
}

class TimeSelector extends StatelessWidget {
  final buttonPadding = const EdgeInsets.fromLTRB(0, 8, 0, 0);

  final List<String> data;
  final String label;

  TimeSelector({required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text(label)),
        Padding(
          padding: buttonPadding,
          child: Container(
            decoration: _getShadowDecoration(),
            child: Card(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        child: DirectSelectList<String>(
                          values: data,
                          onUserTappedListener: () {},
                          onItemSelectedListener: (item, index, context) {},
                          itemBuilder: (String value) =>
                              getDropDownMenuItemTime(value),
                          focusedItemDecoration: _getDslDecoration(),
                        ),
                        padding: EdgeInsets.only(left: 12))),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: _getDropdownIcon(),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  DirectSelectItem<String> getDropDownMenuItemTime(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          _tempov = int.parse(value.substring(0, 2));
          return Text(value);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(0.0, 0.0),
          blurRadius: 15.0,
        ),
      ],
    );
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Colors.blueAccent,
    );
  }
}


// Widget _getFoodContainsRow() {
//   final cardSize = 80.0;
//   final cardColor = Colors.blueGrey[100];
//   return Padding(
//     padding: EdgeInsets.only(left: 8, right: 8),
//     child: Row(
//       children: <Widget>[
//         Expanded(
//           child: Container(
//               child: Center(child: Text("226")),
//               height: cardSize,
//               margin: EdgeInsets.only(right: 3),
//               decoration: BoxDecoration(
//                   color: cardColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(10.0),
//                       bottomLeft: const Radius.circular(10.0)))),
//         ),
//         Expanded(
//           child: Container(
//               child: Center(child: Text("41")),
//               height: cardSize,
//               margin: EdgeInsets.only(right: 3),
//               decoration: BoxDecoration(color: cardColor)),
//         ),
//         Expanded(
//           child: Container(
//               child: Center(child: Text("0")),
//               height: cardSize,
//               margin: EdgeInsets.only(right: 3),
//               decoration: BoxDecoration(color: cardColor)),
//         ),
//         Expanded(
//           child: Container(
//               child: Center(child: Text("4.5")),
//               height: cardSize,
//               decoration: BoxDecoration(
//                   color: cardColor,
//                   borderRadius: BorderRadius.only(
//                       topRight: const Radius.circular(10.0),
//                       bottomRight: const Radius.circular(10.0)))),
//         ),
//       ],
//     ),
//   );
// }


