import 'package:get/get.dart';
import 'package:opentdcsapp/main.dart';
import 'package:opentdcsapp/screens/configtdcs.dart';
import 'package:opentdcsapp/screens/eegresults.dart';
import 'package:opentdcsapp/screens/profile.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => MyHomePage()),
    GetPage(name: '/config', page: () => ConfigTdcs()),
    GetPage(name: '/eegresult', page: () => EegResults(visible: true,)),
    GetPage(name: '/profile', page: () => ProfileSample(name: "",)),
  ];
}
