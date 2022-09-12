import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:opentdcsapp/controller/ctdcs.dart';
import 'package:opentdcsapp/screens/addsamplepage.dart';
import 'package:opentdcsapp/screens/samplepage_study.dart';
import 'package:opentdcsapp/utils/custom_icons.dart';
import 'screens/tdcspage.dart';
import 'screens/eegpage.dart';
import 'screens/samplepage_study.dart';
import 'utils/routes.dart';

final c = Get.put(ControllerTdcs.to);

void main() async {
  await GetStorage.init();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  final GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpentDCs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(primary: Colors.black),
        ),
      ),
      initialRoute: '/',
      getPages: Routes.routes,
      builder: EasyLoading.init(),
    );
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
            Obx(() => Text(c.nameSample.value)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AddSample());
              },
              icon: Icon(Icons.add))
        ],
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
