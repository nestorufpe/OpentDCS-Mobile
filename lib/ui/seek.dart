import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

final c = Get.put(ControllerTdcs.to);

class ExampleViewModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget? innerWidget;

  ExampleViewModel(
      {required this.pageColors,
      required this.appearance,
      this.min = 0,
      this.max = 2.1,
      this.value = 0.5,
      this.innerWidget});
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final customWidth01 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 15, shadowWidth: 50);
final customColors01 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.5),
    trackColor: HexColor('#000000').withOpacity(0.1),
    progressBarColors: [
      HexColor('#3586FC').withOpacity(0.1),
      HexColor('#FF8876').withOpacity(0.25),
      HexColor('#3586FC').withOpacity(0.5)
    ],
    shadowColor: HexColor('#133657'),
    shadowMaxOpacity: 0.02);

final info01 = InfoProperties(
  bottomLabelStyle: TextStyle(
      color: HexColor('#002D43'), fontSize: 20, fontWeight: FontWeight.w700),
  bottomLabelText: 'mA',
  mainLabelStyle: TextStyle(
      color: Colors.black, fontSize: 48.0, fontWeight: FontWeight.bold),
  modifier: (double value) {
    final mA = value.toStringAsPrecision(2);
    return '$mA';
  },
);

final CircularSliderAppearance appearance01 = CircularSliderAppearance(
    customWidths: customWidth01,
    customColors: customColors01,
    startAngle: 55,
    angleRange: 110,
    size: 250.0,
    infoProperties: info01,
    counterClockwise: true);

Widget CustomSeek(BuildContext context, double max) {
  final ExampleViewModel viewModel =
      ExampleViewModel(appearance: appearance01, value: max, pageColors: [
    HexColor('#FFFFFF'),
    HexColor('#EEEEEE'),
    HexColor('#FFFFFF'),
    HexColor('#DDDDDD')
  ]);
  return SleekCircularSlider(
    onChangeStart: (double value) {},
    onChangeEnd: (double value) {
      c.setCurrentReal(value);
    },
    innerWidget: viewModel.innerWidget,
    appearance: viewModel.appearance,
    min: viewModel.min,
    max: viewModel.max,
    initialValue: viewModel.value,
  );
}
