import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/ui/auth/pages/sign_in_page.dart';
import 'package:medium_uz/ui/auth/pages/register_page.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          isLoginPage ? "Sign Up" : "Sign In",
          style:  TextStyle(
              color: AppColors.c_3669C9,
              fontWeight: FontWeight.w800,
              fontSize: 25.sp),
        ),
      ),
      body: isLoginPage
          ? RegisterScreen(

            )
          : SignInScreen(

            ),
      backgroundColor: Colors.white,
    );
  }
}
