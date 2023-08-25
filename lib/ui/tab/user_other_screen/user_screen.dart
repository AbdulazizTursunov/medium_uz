import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubit/user_cubit/user_cubit.dart';
import '../../../cubit/user_cubit/user_cubit_state_dio.dart';
import '../../../cubit/user_cubit/user_model_dio/user_model_dio.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user screen"),
      ),
      body: BlocConsumer<UserCubitDio, UserDioState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is UserGetState){
            return ListView(
              children: [
                ...List.generate(
                  state.userModelDio.length,
                      (index) {
                    UserModelDio user =
                    state.userModelDio[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.teal
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.network(
                            user.avatar_url,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(user.userName,
                            style: TextStyle(color: Colors.black)),
                        trailing:
                        Text(user.state, style: TextStyle(color: Colors.black)),
                      ),
                    );
                  },
                ),
              ],
            );
          }else{
            return SizedBox();
          }
        },
        listener: (context, state) {
          if (state is UserLoadingState) {
            const Center(child: CircularProgressIndicator());
          }
          if (state is UserErrorState) {
            Center(child: Text("state.toString()"));
          }
        },
      ),
    );
  }
}
