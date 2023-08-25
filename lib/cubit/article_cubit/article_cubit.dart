import 'package:bloc/bloc.dart';
import '../../data/models/universal_data/universal_data.dart';
import '../../data/repositories/article_repository.dart';
import 'article_model.dart';
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

}
