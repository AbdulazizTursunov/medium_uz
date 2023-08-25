import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';


class GenderSelectorRadioButton extends StatefulWidget {
  const GenderSelectorRadioButton({Key? key}) : super(key: key);

  @override
  State<GenderSelectorRadioButton> createState() => _GenderSelectorRadioButtonState();
}

class _GenderSelectorRadioButtonState extends State<GenderSelectorRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          activeColor: AppColors.c_3669C9,
          value: "male",
          groupValue: "male",
          onChanged: (value) {

          context.read<UserDataCubit>().state.userModel.gender = value!;
          },
          title:  Text(
            'Male',
            style: TextStyle(color: AppColors.c_3669C9),
          ),
        ),
        RadioListTile(
          activeColor:AppColors.c_3669C9,
          value: "female",
          groupValue: "female",
          onChanged: (value) {
              context.read<UserDataCubit>().state.userModel.gender = value!;
          },
          title:  Text(
            'Female',
            style: TextStyle(color:AppColors.c_3669C9),
          ),
        ),
      ],
    );
  }
}
