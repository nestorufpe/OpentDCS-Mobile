import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class EegResults extends StatefulWidget {
  final bool visible;

  const EegResults({Key? key, required this.visible}) : super(key: key);
  @override
  State<EegResults> createState() => _EegResultsState(visible);
}

class _EegResultsState extends State<EegResults> {
  final bool visible;

  _EegResultsState(this.visible);
  
  @override
  Widget build(BuildContext context) {
    const ticks = [50, 100, 150, 200];
    var features = ["Delta", "Theta", "Alpha", "Beta"];
    var data = [
      [50,100,150, 177.98],
      // [14.5, 1, 4, 14, 23, 10, 6, 19]
    ];
    return SafeArea(
      child: Column(children: [
        Expanded(flex:2,child: RadarChart(ticks: ticks, features: features, data: data,graphColors: [Colors.blue],)),
        Expanded(flex:1,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text("Average Band Spectral Power (mV²/Hz)", textAlign: TextAlign.center, style: TextStyle(color:Colors.black54, fontWeight: FontWeight.bold),),
              ),
          Visibility(
            visible: visible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){}, child: Text("Salvar")),
            ),
          ),
          Visibility(
            visible: visible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(onPressed: (){}, child: Text("Descartar")),
            ),
          )
          ],),
        )
        ,
      ],),
    );
  }
}