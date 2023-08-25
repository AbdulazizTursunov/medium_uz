part of 'profile_cubit.dart';

@immutable
abstract class ProfileState  extends Equatable{}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final UserModel userModel;
  ProfileSuccessState({required this.userModel});
  @override
  List<Object?> get props => [userModel];
}

class ProfileErrorState extends ProfileState {
  ProfileErrorState({required this.error});
  final String error;
  @override
  List<Object?> get props => [error];
}




