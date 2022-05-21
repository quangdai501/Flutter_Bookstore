import 'package:final_project/provider/base_provider.dart';

class AuthProvider extends BaseProvider {
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  // login
  Future<Map<String, dynamic>> login(Map<String, String> body) async {
    try {
      String url = 'auth/login';
      final response = await post(url, body);

      var data = response.body;
      if (response.status.hasError) {
        throw data;
      }
      return data;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // register step 1
  Future<Map<String, dynamic>> registerSentCodeToEmail(
      Map<String, String> body) async {
    try {
      String url = 'auth/confirm-email';
      final response = await post(url, body);
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // register step 2
  Future<Map<String, dynamic>> registerEnterCode(
      Map<String, String> body) async {
    try {
      String url = 'users/add-user';
      final response = await post(url, body);
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // forgot password step 1
  Future<Map<String, dynamic>> forgotPasswoodSentCode(
      Map<String, String> body) async {
    try {
      String url = 'auth/fogot-password';
      final response = await post(url, body);
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // forgot password step 2
  Future<Map<String, dynamic>> forgotPasswoodEnterCode(
      Map<String, String> body) async {
    try {
      String url = 'auth/enter-code-reset-pass';
      final response = await post(url, body);
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  // forgot password step 3
  Future<Map<String, dynamic>> forgotPasswoodResetPassword(
      Map<String, String> body) async {
    try {
      String url = 'auth/reset-pass';
      final response = await put(url, body);
      if (response.hasError) {
        throw response.body;
      }
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
