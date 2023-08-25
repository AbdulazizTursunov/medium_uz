import 'package:medium_uz/data/models/user_model/user_model.dart';

class UserDataState {
  String errorText;
  UserModel userModel;

  UserDataState({required this.userModel, required this.errorText});

  factory UserDataState.fromJson(Map<String, dynamic> json) {
    return UserDataState(
        userModel: json['userModel'],
        errorText: json['errorText'] as String? ?? "");
  }

  UserDataState copyWith({
    String? errorText,
    UserModel? userModel,
  }) =>
      UserDataState(
          userModel: userModel ?? this.userModel,
          errorText: errorText ?? this.errorText);



  Map<String,dynamic> toJson(){
    return {
      "userModel":userModel,
      "errorText":errorText,
    };
  }




}
