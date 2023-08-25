

import 'package:equatable/equatable.dart';
import 'package:medium_uz/cubit/user_cubit/user_model_dio/user_model_dio.dart';
abstract class UserDioState  extends Equatable {}

class UserInitial extends UserDioState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserDioState{
  @override
  List<Object?> get props => [];
}

class UserGetState extends UserDioState {

  UserGetState({required this.userModelDio});
  final List<UserModelDio> userModelDio;
  @override
  List<Object?> get props => [userModelDio];
}


class UserErrorState extends UserDioState {
  UserErrorState({required this.errorText});
  final String errorText;
  @override
  List<Object?> get props => [errorText];
}
