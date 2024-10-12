import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpModel signUpModel) async {
    Response response = await apiClient.postData(AppConstants.REGISTRATION_URI, signUpModel.serialize());
    return response;
  }

  saveUserToken(String token) async {
    apiClient.saveUserToken(token);
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
}
