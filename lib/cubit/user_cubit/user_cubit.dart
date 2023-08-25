import 'package:bloc/bloc.dart';
import 'package:medium_uz/cubit/user_cubit/user_cubit_state_dio.dart';
import 'package:medium_uz/cubit/user_cubit/user_model_dio/user_model_dio.dart';
import 'package:medium_uz/data/repositories/user_repository.dart';
import '../../data/models/universal_data/universal_data.dart';


class UserCubitDio extends Cubit<UserDioState> {
  UserCubitDio({required this.userRepositories}) : super(UserInitial()){
    getInfoUsers();
  }

  List<UserModelDio> userModelDio = [];

  final USerRepositories userRepositories;

  Future<void> getInfoUsers()async{
    emit(UserLoadingState());
    UniversalData universalData = await userRepositories.getUser();
    print(universalData.data);
    if(universalData.error.isEmpty){
      userModelDio = universalData.data as List<UserModelDio>;
      emit(UserGetState(userModelDio: universalData.data as List<UserModelDio>));
    }else{
      emit(UserErrorState(errorText: universalData.error));
    }
  }

}
