

import 'package:medium_uz/data/network/api_service.dart';

import '../models/universal_data/universal_data.dart';

class ProfileRepository{

  ApiService apiService;
  ProfileRepository({required this.apiService});


  Future<UniversalData> getUserInfo() async => apiService.getAllArticles();

}