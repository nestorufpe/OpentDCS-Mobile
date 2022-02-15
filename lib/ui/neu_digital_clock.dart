import 'package:flutter/material.dart';
import 'package:opentdcsapp/ui/digital_colon.dart';
import 'package:opentdcsapp/ui/digital_number.dart';

class NeuDigitalClock extends StatelessWidget {
  const NeuDigitalClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromRGBO(217, 230, 243, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: Offset(-5, -5),
            color: Colors.white,
          ),
          BoxShadow(
            blurRadius: 15,
            offset: Offset(10.5, 10.5),
            color: Color.fromRGBO(214, 223, 230, 1),
          )
        ],
      ),
      // Digital green background
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            height: constraints.maxHeight * 0.87,
            width: constraints.maxWidth * 0.95,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(203, 211, 196, 1),
                Color.fromRGBO(176, 188, 163, 1)
              ]),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromRGBO(168, 168, 168, 1),
                width: 2,
              ),
            ),
            child: DigitalClock(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              seconds: 05,
              minutes: 12,
              hours: 5,
            ),
          ),
        ),
      ),
    );
  }
}

class DigitalClock extends StatelessWidget {
  const DigitalClock({
    required this.height,
    required this.width,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  final num height;
  final num width;
  final int hours;
  final int minutes;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    List<DigitalNumberWithBG> hourNumber = createNumberTime(hours);
    List<DigitalNumberWithBG> minuteNumber = createNumberTime(minutes);
    // List<DigitalNumberWithBG> secondNumber = createNumberTime(seconds);
    return Center(
      child: Container(
        // color: Colors.green,
        height: height * 0.47,
        width: width * 0.70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...hourNumber,
            DigitalColon(height: height * 0.30, color: Colors.black87),
            ...minuteNumber,
            // DigitalColon(height: height * 0.30, color: Colors.black87),
            // ...secondNumber,
          ],
        ),
      ),
    );
  }

  List<DigitalNumberWithBG> createNumberTime(int numberTime) {
    final parsedNumberTime = numberTime % 60;
    final isNumberTimeTwoDigits = isNumberTwoDigits(parsedNumberTime);
    final firstNumber = firstDigit(parsedNumberTime);
    final tenDigit = isNumberTimeTwoDigits ? firstNumber : 0;
    final digit = isNumberTimeTwoDigits
        ? int.parse(parsedNumberTime.toString()[1])
        : firstNumber;

    return [
      DigitalNumberWithBG(
        height: height * 0.45,
        value: tenDigit,
        padLeft: 0,
        color: Colors.red,
      ),
      DigitalNumberWithBG(
        height: height * 0.45,
        value: digit,
        padLeft: 0,
        color: Colors.red,
      ),
    ];
  }
}

class DigitalNumberWithBG extends StatelessWidget {
  const DigitalNumberWithBG({
    Key? key,
    this.value = 0,
    required this.padLeft,
    required this.height,
    required this.color,
    this.backgroundValue = 8,
  }) : super(key: key);

  final int value;
  final int backgroundValue;
  final int padLeft;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //Foreground
        DigitalNumber(
          value: value,
          color: Colors.black,
          height: height,
        ),

        // Background
        DigitalNumber(
          value: backgroundValue,
          color: Colors.black12,
          height: height,
        ),
      ],
    );
  }
}

bool isNumberTwoDigits(int number) {
  return number.toString().length == 2;
}

int firstDigit(int number) {
  return int.parse(number.toString()[0]);
}
