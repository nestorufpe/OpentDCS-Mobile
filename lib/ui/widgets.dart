import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:opentdcsapp/ui/seek.dart';
import 'package:opentdcsapp/utils/custom_icons.dart';

Widget CircleButton(BuildContext context) {
  return Center(
    child: NeumorphicButton(
      onPressed: () {
        print("click");
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.settings,
          color: Colors.black,
          size: 42,
        ),
      ),
    ),
  );
}

Widget CircleBtnPlay(BuildContext context) {
  return Center(
    child: NeumorphicButton(
      onPressed: () {
        print("click");
      },
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.play_arrow,
          color: Colors.black,
          size: 64,
        ),
      ),
    ),
  );
}

Widget ContainerNeu(BuildContext context) {
  return Neumorphic(
    style: NeumorphicStyle(
      color: Colors.white,
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.circle(),
    ),
    padding: EdgeInsets.all(18.0),
    child: CustomSeek(context),
  );
}

Widget ContainerNeuValues(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Neumorphic(
          margin: EdgeInsets.all(5),
          style: NeumorphicStyle(
            color: Colors.white,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(12))),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Intesidade",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "2mA",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.circle,
                      size: 12,
                      color: Colors.green,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        child: Neumorphic(
          margin: EdgeInsets.all(5),
          style: NeumorphicStyle(
            color: Colors.white,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(12))),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Impedância",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "9 kΩ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.circle,
                      size: 12,
                      color: Colors.red,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
