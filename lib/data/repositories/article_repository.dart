import '../models/universal_data/universal_data.dart';
import '../network/api_service.dart';

class ArticleRepositories{


  final ApiService apiService;

  ArticleRepositories({required this.apiService});

  Future<UniversalData> getArticle()=>apiService.getAllArticles();

  Future<UniversalData> getArticleById({required int idArticle })=>apiService.getArticleById(idArticle: idArticle);


}