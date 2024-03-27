import 'package:dio_best_practise/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final box = GetStorage();

  String? get accessToken => box.read('accessToken');
  String? get refreshToken => box.read('refresshToken');
  bool? get loginStatus => box.read("loginKey");

  Future<void> setAccessToken(String token) async {
    await box.write('accessToken', token);
  }

  Future<void> setLoginStatus(bool key) async {
    await box.write('loginKey', key);
  }

  Future<void> clearToken() async {
    await box.remove('accessToken');
    await box.remove("loginKey");
  }

  Future<void> setRefreshToken(String refToken) async {
    await box.write("refreshToken", refToken);
  }

  Future<void> clearRefToken() async {
    await box.remove("refreshToken");
  }

  logOut() {
    clearToken();
    clearRefToken();
    Get.offAllNamed(Routes.login);
    Get.snackbar("Authentication", "Successfully logged out",
        backgroundColor: Colors.red);
  }
}
