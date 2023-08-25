import 'package:medium_uz/data/network/user_api_service.dart';
import '../models/universal_data/universal_data.dart';


class USerRepositories{


  final UserApiService userApiService;

  USerRepositories({required this.userApiService});

  Future<UniversalData> getUser()=>userApiService.getAllUser();
}