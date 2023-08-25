import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubit/auth/auth_cubit.dart';
import 'package:medium_uz/cubit/profile_cubit/profile_cubit.dart';
import 'package:medium_uz/utils/ui_utils/custom_circular.dart';
import 'package:medium_uz/utils/ui_utils/error_message_dialog.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationCubit>(context).logOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              const Center(
                child: CustomCircularProgressIndicator(),
              );
            }
            if (state is ProfileSuccessState) {
              return ListView(children: [
                Column(
                  children: [
                    Image.network(
                        baseUrl + state.userModel.avatar.substring(1)),
                    Text(state.userModel.email,style: Theme.of(context).textTheme.labelSmall,),
                  ],
                ),

              ]);
            } else {
              const Text("ERRORGA TUSHDI loading stateda",style: TextStyle(color: AppColors.black),);
            }
            return const Text("ERROR",style: TextStyle(color: AppColors.black),);
          },
          listener: (BuildContext context, ProfileState state) {
            if (state is ProfileErrorState) {
              showErrorMessage(message: state.error, context: context);
            }
          },
        ));
  }
}
