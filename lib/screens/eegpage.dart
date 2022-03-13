import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../ui/widgets.dart';

class EEGPage extends StatefulWidget {
  const EEGPage({Key? key}) : super(key: key);

  @override
  State<EEGPage> createState() => _EEGPageState();
}

class _EEGPageState extends State<EEGPage> {
  List<GridListItems> items = [
    GridListItems(color: Colors.green, title: 'Ch1'),
    GridListItems(
      color: Colors.green,
      title: 'Ch2',
    ),
    GridListItems(
      color: Colors.red,
      title: 'Ch3',
    ),
    GridListItems(color: Colors.green, title: 'Ch4'),
    GridListItems(color: Colors.red, title: 'Ch5'),
    GridListItems(color: Colors.green, title: 'Ch6'),
    GridListItems(color: Colors.green, title: 'Ch7'),
    GridListItems(color: Colors.green, title: 'Ch8'),
  ];

  Timer? _timer;
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = 0;
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.showSuccess('Use in initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Indicação da resistência
          SingleChildScrollView(
            child: Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Ajuste de Impedância",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 14),
                            child: Text(
                              "Ajuste o contato dos eletrodos com o escalpo para reduzir a resitência. Os canais em vermelho são os de impedância elevada.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                        ),
                        Text("Ruim"),
                        SizedBox(
                          width: 14,
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                        ),
                        Text("Bom"),
                      ],
                    ),
                  ],
                )),
          ),
          //GridView com os canais/loading/radar chart
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: (2 / 1),
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              padding: EdgeInsets.only(left: 8, top: 24, right: 8.0, bottom: 8),
              children: items
                  .map(
                    (data) => GestureDetector(
                        onTap: () {},
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            color: data.color,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.all(Radius.circular(24))),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data.title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        )),
                  )
                  .toList(),
            ),
          ),
          //Config e Play
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleButtonRts(context, () {
                      setState(() {
                        items[2] =
                            GridListItems(color: Colors.green, title: "Ch3");
                        items[4] =
                            GridListItems(color: Colors.green, title: "Ch5");
                      });
                    }),
                    CircleBtnPlayEeg(context, _progress, _timer),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class GridListItems {
  final Color color;
  final String title;

  GridListItems({required this.color, required this.title});
}
