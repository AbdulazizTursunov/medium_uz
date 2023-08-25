import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:medium_uz/cubit/auth/abstract_auth_state.dart';
import '../../data/models/universal_data/universal_data.dart';
import '../../data/models/user_model/user_model.dart';
import '../../data/repositories/auth_repository.dart';



class AuthenticationCubit  extends Cubit<AuthState>{

  AuthenticationCubit({required this.authRepository}) : super(AuthInitial());

  final AuthRepo authRepository;

  Future<void> checkLoggedState() async {
    await Future.delayed(const Duration(seconds: 3));
    if (authRepository.getTokenUser().isEmpty) {
      emit(AuthUnAuthenticatedState());
    } else {
      emit(AuthLoggedState());
    }
  }


  Future<void> sendCodeToGmail(String gmail, String password) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.sendCodeGmailUser(
      email: gmail,
      password: password,
    );
    if (universalData.error.isEmpty) {
      emit(AuthSendCodeSuccessState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }

  Future<void> confirmGmail(String code) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.confirmCodeApi(code: code);
    if (universalData.error.isEmpty) {
      emit(AuthConfirmCodeSuccessState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }

  Future<void> registerUser(UserModel userModel) async {
    emit(AuthLoadingState());
    UniversalData universalData =
    await authRepository.registerUserMediumUz(userModel: userModel);
    if (universalData.error.isEmpty) {
      debugPrint("TOKEN=======================================${universalData.data}");
    await  authRepository.setTokenUser(universalData.data as String);
      emit(AuthLoggedState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }

  Future<void> loginUser({
    required String gmail,
    required String password,
  }) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.loginUserMediumUz(
      email: gmail,
      password: password,
    );
    if (universalData.error.isEmpty) {
      debugPrint("TOKEN${universalData.data}");
      authRepository.setTokenUser(universalData.data as String);
      emit(AuthLoggedState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }


  Future<void> logOut() async {
    emit(AuthLoadingState());
    bool? isDeleted = await authRepository.deleteTokenUser();
    if (isDeleted != null) {
      emit(AuthUnAuthenticatedState());
    }
  }


}