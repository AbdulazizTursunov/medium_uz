part of 'website_cubit.dart';

abstract class WebsiteState extends Equatable {}


class WebsiteInitial extends WebsiteState {
  @override
  List<Object?> get props => [];
}


class WebsiteLoadingState extends WebsiteState{
  @override
  List<Object?> get props => [];
}


class WebsiteGetState extends WebsiteState {
  WebsiteGetState({required this.websiteModel});
  final List<WebsiteModel> websiteModel;
  @override
  List<Object?> get props => [websiteModel];
}


class WebsiteGetStateById extends WebsiteState {
  WebsiteGetStateById({required this.webModel});
  final WebsiteModel webModel;
  @override
  List<Object?> get props => [webModel];
}


class WebsiteErrorState extends WebsiteState {
  WebsiteErrorState({required this.errorText});
  final String errorText;
  @override
  List<Object?> get props => [errorText];
}
