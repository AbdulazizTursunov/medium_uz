import 'package:bloc/bloc.dart';
import '../../data/models/universal_data/universal_data.dart';
import '../../data/repositories/article_repository.dart';
import '../../data/models/article_model/article_model.dart';
import 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit({required this.articleRepositories}) : super(ArticleInitial()){
    getInfoArticle();
  }
List<ArticleModel> articleModel = [];

  final ArticleRepositories articleRepositories;


  Future<void> getInfoArticle()async{
    emit(ArticleLoadingState());
    UniversalData universalData = await articleRepositories.getArticle();
    if(universalData.error.isEmpty){
      articleModel = universalData.data as List<ArticleModel>;
      emit(ArticleGetState(articleModel: universalData.data as List<ArticleModel>));
    }else{
      emit(ArticleErrorState(errorText: universalData.error));
    }
  }

  Future<void> getInfoArticleById({required int idArticle})async{
    emit(ArticleLoadingState());
    UniversalData universalData = await articleRepositories.getArticleById(idArticle:idArticle );
    if(universalData.error.isEmpty){
      // print("DATAAAAAAAAAAAAA:  ${universalData.data}");

      universalData.data as ArticleModel;
      emit(ArticleGetStateById(artModel: universalData.data));
    }else{
      emit(ArticleErrorState(errorText: universalData.error));
    }
  }


}
