import 'package:flutter/material.dart';
import 'package:medium_uz/ui/auth/pages/sign_in_page.dart';
import '../../data/models/user_model/user_model.dart';
import '../auth/auth_screen.dart';
import '../auth/pages/code_input.dart';
import '../auth/pages/register_page.dart';
import '../splash/splash_screen.dart';
import '../tab/tab_box.dart';


class RouteNames {
  static const String splashScreen = "/";
  static const String authScreen = "/auth_screen";
  static const String tabBox = "/tab_box";
  static const String registerScreen = "/register_screen";
  static const String signIn = "/sign_in_screen";
  static const String confirmGmailCode = "/confirm_gmail";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteNames.authScreen:
        return MaterialPageRoute(builder: (context) {
          return AuthScreen();
        });

      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => TabBox());

      case RouteNames.confirmGmailCode:
        return MaterialPageRoute(builder: (context) => CodeInput(
          userModel: settings.arguments as UserModel,
        ));
      case RouteNames.signIn:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        });

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route mavjud emas"),
            ),
          ),
        );
    }
  }
}
