import 'dart:math';

import 'package:dio_best_practise/controllers/login_controllers.dart';

import 'package:dio_best_practise/routes/get_routes.dart';
import 'package:dio_best_practise/routes/routes.dart';
import 'package:dio_best_practise/services/storage/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/home.dart';

void main() async{
   await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final authService = Get.put(AuthService());
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    print("login status ${authService.loginStatus}");
    loginController.initAuthStatus();
    return GetMaterialApp(
      initialRoute: authService.loginStatus == true ? '/home' : '/login',
      getPages: GetRoutes.getRoutes(),
      // routingCallback: (value) => Get.put(AuthGuard()),

      // home: HomePage(),
    );
  }
}
