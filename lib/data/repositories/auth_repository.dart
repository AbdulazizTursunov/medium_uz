import 'package:medium_uz/data/network/api_service.dart';
import '../local/storage_repository.dart';
import '../models/universal_data/universal_data.dart';
import '../models/user_model/user_model.dart';

class AuthRepo {
  ApiService apiService;

  AuthRepo({required this.apiService});






  Future<UniversalData> sendCodeGmailUser(
      {required String email, required String password}) async =>
      apiService.sendCodeGmailUser(email: email, password: password);

  Future<UniversalData> confirmCodeApi({required String code}) async =>
      apiService.confirmCodeApi(code: code);

  Future<UniversalData> registerUserMediumUz(
      {required UserModel userModel}) async =>
     await apiService.registerUserMediumUz(userModel: userModel);


  Future<UniversalData> loginUserMediumUz(
      {required String email, required String password}) async =>
      apiService.loginUserMediumUz(email: email, password: password);

  String getTokenUser() => StorageRepository.getString("token");

  Future<bool?> deleteTokenUser() async => StorageRepository.deleteString("token");

  Future<void> setTokenUser(String newToken) async =>
      StorageRepository.putString("token", newToken);
}
