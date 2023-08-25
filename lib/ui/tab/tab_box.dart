import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubit/auth/auth_cubit.dart';
import 'package:medium_uz/cubit/tab_cubit/tab_box_cubit.dart';
import 'package:medium_uz/ui/tab/profile_screen/profile_screen.dart';
import 'package:medium_uz/ui/tab/user_other_screen/user_screen.dart';

import '../../cubit/auth/abstract_auth_state.dart';
import '../routes/app_routes.dart';
import 'article_screen/article_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}
class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      ArticlesScreen(),
      ProfileScreen(),
      UserInfoScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthState>(
        child: screens[context.watch<TabCubit>().state],
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.registerScreen);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline_sharp), label: "users"),
        ],
        currentIndex: context.watch<TabCubit>().state,
        onTap: context.read<TabCubit>().changeTabCurrentIndex

      ),
    );
  }
}
