import 'package:dio/dio.dart';
import 'package:dio_best_practise/const/api_const.dart';
import 'package:dio_best_practise/services/storage/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

import '../services/dio services/dio_client.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.put(AuthService());

  RxBool loading = false.obs;
  var errormessage = "".obs;
  setLoading(bool load) {
    loading.value = load;
  }

  initAuthStatus() {
    if (authService.accessToken != null) {
      authService.setLoginStatus(true);
    } else {
      authService.setLoginStatus(false);
    }
  }

  void logOut() {
    authService.clearToken();
  
  }

  final ApiService apiService = ApiService();
  login(Map<String, String> userCreds) async {
    try {
      setLoading(true);
      print("user info $userCreds");
      var resp = await apiService.post(ApiConst.loginEndpoint, data: userCreds);

      print("response data ${resp.toString()}");
      authService.setAccessToken(resp['token']);

      errormessage.value = "";
    } catch (e) {
      print("entire error $e");
      authService.clearToken();
      if (e is DioExceptions) {
        print("11111${e.toString()}");
        errormessage.value = e.message!;
      }
      if (e is DioError) {
        print(" dio errrrrrrrrorrrr${e.response!.data.toString()}");
      }

      print("error in controller class ");
    } finally {
      initAuthStatus();

      setLoading(false);
    }
  }
}
