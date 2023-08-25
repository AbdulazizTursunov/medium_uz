import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medium_uz/data/models/user_model/user_model.dart';
import 'package:medium_uz/data/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/universal_data/universal_data.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepository})
      : super(ProfileInitialState());

  ProfileRepository profileRepository;

  getUserInfo() async {
    emit(ProfileLoadingState());
    UniversalData universalData = await profileRepository.getUserInfo();
    if (universalData.error.isEmpty) {
      emit(ProfileSuccessState(userModel: universalData.data as UserModel));
    } else {
      emit(ProfileErrorState(error: universalData.error));
    }
  }
}
