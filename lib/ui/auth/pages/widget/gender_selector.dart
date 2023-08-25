import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:medium_uz/data/models/user_model/user_model_enum_filds.dart';

import '../../../../utils/colors/app_colors.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    String gender = context.read<UserDataCubit>().state.userModel.gender;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor:
              gender == "male" ? AppColors.c_3669C9 : AppColors.white),
          onPressed: (){
            context.read<UserDataCubit>().updateCurrentUserField(userModelFieldKeys: UserModelFieldKeys.gender, value: "male");
          },
          child: Text(
            "MALE",
            style: TextStyle(
                color: gender == "male" ? AppColors.white : AppColors.black),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                gender == "female" ? AppColors.c_3669C9 : AppColors.white),
            onPressed: (){
    context.read<UserDataCubit>().updateCurrentUserField(userModelFieldKeys: UserModelFieldKeys.gender, value: "female");
    },
            child: Text(
              "FEMALE",
              style: TextStyle(
                  color: gender == "female" ? AppColors.white : AppColors.black),
            )),
      ],
    );
  }
}
