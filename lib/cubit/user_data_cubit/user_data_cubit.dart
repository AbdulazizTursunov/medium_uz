import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubit/user_data_cubit/user_data_helper_cubit.dart';
import 'package:medium_uz/data/models/user_model/user_model.dart';
import 'package:medium_uz/data/models/user_model/user_model_enum_filds.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit()
      : super(UserDataState(
            userModel: UserModel(
                password: '',
                username: '',
                email: '',
                avatar: '',
                contact: '',
                gender: '',
                profession: '',
                role: ''),
            errorText: ''));

  updateCurrentUserField({
    required UserModelFieldKeys userModelFieldKeys,
    required dynamic value,
  }) {
    UserModel currentUserModel = state.userModel;

    switch (userModelFieldKeys) {
      case UserModelFieldKeys.username:
        {
          currentUserModel = currentUserModel.copyWith(
              username: value as String);
          break;
        }
      case UserModelFieldKeys.avatar:
        {
          currentUserModel = currentUserModel.copyWith(
              avatar: value as String) ;
          break;
        }
      case UserModelFieldKeys.gender:
        {
          currentUserModel = currentUserModel.copyWith(
              gender: value as String);
          break;
        }
      case UserModelFieldKeys.role:
        {
          currentUserModel = currentUserModel.copyWith(role: value as String);
          break;
        }
      case UserModelFieldKeys.profession:
        {
          currentUserModel = currentUserModel.copyWith(
              profession: value as String);
          break;
        }
      case UserModelFieldKeys.password:
        {
          currentUserModel = currentUserModel.copyWith(
              password: value as String);
          break;
        }
      case UserModelFieldKeys.contact:
        {
          currentUserModel = currentUserModel.copyWith(
              contact: value as String);
          break;
        }
      case UserModelFieldKeys.email:
        {
          currentUserModel = currentUserModel.copyWith(email: value as String);
          break;
        }
      default:
        {
          Text("bunday keys mavjud emas");
        }

    }
    debugPrint("USER: ${currentUserModel.toString()}");

    emit(state.copyWith(userModel: currentUserModel));
  }

  bool canRegister() {
    UserModel currentUser = state.userModel;

    if (currentUser.contact.length < 9) {
      return false;
    }
    if (currentUser.username.isEmpty) {
      return false;
    }
    if (currentUser.avatar.isEmpty) {
      return false;
    }
    if (currentUser.email.isEmpty) {
      return false;
    }
    if (currentUser.password.isEmpty) {
      return false;
    }
    if (currentUser.profession.isEmpty) {
      return false;
    }
    if (currentUser.gender.isEmpty) {
      return false;
    }
    return true;
  }



  clearData() {
    emit(
      UserDataState(
        userModel: UserModel(
          password: "",
          username: "",
          email: "",
          avatar: '',
          contact: "",
          gender: "",
          profession: '',
          role: "",
        ),
        errorText: "",
      ),
    );
  }
}
