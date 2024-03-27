import 'package:dio_best_practise/pages/home.dart';
import 'package:dio_best_practise/pages/login.dart';
import 'package:dio_best_practise/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class GetRoutes {
  GetRoutes._();
  static List<GetPage> getRoutes() => [
        GetPage(name: Routes.home, page: () => HomePage()),
        GetPage(name: Routes.login, page: () => LoginPage()),
      ];
}
