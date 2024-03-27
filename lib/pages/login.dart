import 'package:dio_best_practise/controllers/login_controllers.dart';
import 'package:dio_best_practise/routes/routes.dart';
import 'package:dio_best_practise/services/storage/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginController = Get.put(LoginController());
  final authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "User Id"),
              controller: idController,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "User Id"),
              controller: passwordController,
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => loginController.loading.value
                ? CircularProgressIndicator()
                : TextButton(
                    onPressed: () async {
                      Map<String, String> userCreds = {
                        "email": idController.text,
                        "password": passwordController.text
                      };
                      await loginController.login(userCreds);

                      if (loginController.errormessage.isNotEmpty) {
                        Get.snackbar("Failed to Login",
                            loginController.errormessage.value);
                      }
                      if (authService.loginStatus == true) {
                        Get.offAllNamed(Routes.home);
                        Get.snackbar("Authentication", "Log in success",
                            backgroundColor: Colors.green);
                      }
                    },
                    child: Text("Login")))
          ],
        ),
      ),
    );
  }
}
