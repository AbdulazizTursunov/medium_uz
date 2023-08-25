import 'article_model.dart';
import 'package:equatable/equatable.dart';
abstract class ArticleState  extends Equatable {}

class ArticleInitial extends ArticleState {
  @override
  List<Object?> get props => [];
}

class ArticleLoadingState extends ArticleInitial{
  @override
  List<Object?> get props => [];
}

class ArticleGetState extends ArticleState {

  ArticleGetState({required this.articleModel});
  final List<ArticleModel> articleModel;
  @override
  List<Object?> get props => [articleModel];
}


class ArticleErrorState extends ArticleState {
  ArticleErrorState({required this.errorText});
  final String errorText;
  @override
  List<Object?> get props => [errorText];
}
