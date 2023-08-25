import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubit/auth/auth_cubit.dart';
import '../../cubit/auth/abstract_auth_state.dart';
import '../../data/local/storage_repository.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _init() async {
    if (StorageRepository.getString("token").isEmpty) {
      Navigator.pushReplacementNamed(context, RouteNames.authScreen);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.authScreen);
    }
  }


  @override
  void initState() {
    BlocProvider.of<AuthenticationCubit>(context).checkLoggedState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Splash"),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthState>(
        builder: (context, state) {
          return const Center(child: Text("Splash"));
        },
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.registerScreen);
          }
          if (state is AuthLoggedState) {
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }
        },
      ),
    );
  }
}
