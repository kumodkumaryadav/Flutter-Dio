import 'package:dio_best_practise/controllers/login_controllers.dart';
import 'package:dio_best_practise/routes/routes.dart';
import 'package:dio_best_practise/services/storage/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homep Page"),
      ),
      body: Column(
        children: [
          const Center(
            child: Text("Login Success"),
          ),
          SizedBox(
            height: 200,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  authService.logOut();
                  // print("login status ${authService.loginStatus}");
                  // if (authService.loginStatus == false)
                  //   Get.offAllNamed(Routes.login);
                },
                child: Text("Log Out")),
          )
        ],
      ),
    );
  }
}
