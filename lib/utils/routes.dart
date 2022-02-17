import 'package:get/get.dart';
import 'package:opentdcsapp/main.dart';
import 'package:opentdcsapp/screens/configtdcs.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => MyHomePage()),
    GetPage(name: '/config', page: () => ConfigTdcs())
  ];
}
