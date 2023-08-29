import '../models/universal_data/universal_data.dart';
import '../models/website_model/website_model.dart';
import '../network/api_service.dart';

class WebsiteRepository {
  final ApiService apiService;

  WebsiteRepository({required this.apiService});

  Future<UniversalData> getWebsites() async => apiService.getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      apiService.getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel newWebsite) async =>
      apiService.createWebsite(websiteModel: newWebsite);
}
