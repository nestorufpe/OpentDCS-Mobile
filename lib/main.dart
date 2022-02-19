import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:opentdcsapp/screens/samplepage.dart';
import 'package:opentdcsapp/utils/custom_icons.dart';
import 'screens/tdcspage.dart';
import 'screens/eegpage.dart';
import 'screens/samplepage.dart';
import 'utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(),
        initialRoute: '/',
        getPages: Routes.routes);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 1;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("Fco José"),
            Text(
              "Parkison",
              style: TextStyle(fontSize: 12, color: Colors.white54),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.group, title: "Amostra"),
          TabData(iconData: CustomIcons.ray, title: "tDCs"),
          TabData(iconData: CustomIcons.eeg, title: "EEG")
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}

_getPage(int page) {
  switch (page) {
    case 0:
      return SamplePage();
    case 1:
      return TDCSPage();
    default:
      return EEGPage();
  }
}
