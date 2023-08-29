import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/data/models/website_model/website_model.dart';
import 'package:medium_uz/data/repositories/website_repositories.dart';
import '../../data/models/universal_data/universal_data.dart';
part 'website_state.dart';

class WebsiteCubit extends Cubit<WebsiteState> {
  WebsiteCubit({required this.websiteRepository}) : super(WebsiteInitial());

  final WebsiteRepository websiteRepository;
List<WebsiteModel> websiteModel= [];

  Future<void> getInfoWebsite()async{
    emit(WebsiteLoadingState());
    UniversalData universalData = await websiteRepository.getWebsites();
    if(universalData.error.isEmpty){
      websiteModel = universalData.data as List<WebsiteModel>;
      emit(WebsiteGetState(websiteModel: universalData.data as List<WebsiteModel>));
    }else{
      emit(WebsiteErrorState(errorText: universalData.error));
    }
  }

  Future<void> getInfoWebsiteById({required int websiteId})async{
    emit(WebsiteLoadingState());
    UniversalData universalData = await websiteRepository.getWebsiteById(websiteId);
    if(universalData.error.isEmpty){
      universalData.data as WebsiteModel;
      emit(WebsiteGetState(websiteModel: universalData.data));
    }else{
      emit(WebsiteErrorState(errorText: universalData.error));
    }
  }


















}
