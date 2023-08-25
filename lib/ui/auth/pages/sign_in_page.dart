import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubit/auth/auth_cubit.dart';
import 'package:medium_uz/ui/auth/widgets/piccet.dart';
import 'package:medium_uz/utils/images/app_images.dart';
import '../../../cubit/auth/abstract_auth_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../routes/app_routes.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_fields.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});



  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String emailController ='';
  String passwordController = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In page"),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              Stack(
                children: [
                  Center(
                      child: Image.asset(
                        AppImages.loginBackground,
                        height: 300,
                        width: 300,
                      ))
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 28.r),
                child:const CaptionText(title: "Email"),
              ),
               SizedBox(height: 10.h),
              GlobalTextField(
                hintText: "Email",
                prefixIconIn: Icons.email,

                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                onChanged:(value){
                  emailController = value;
                }
              ),
               SizedBox(height: 10.h),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 28.r),
                child:const CaptionText(title: "Password"),
              ), SizedBox(height: 10.h),
              GlobalTextField(
                hintText: "Password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                onChanged: (value){
                  passwordController = value;
                },
              ),
              SizedBox(height: 30.h),
              GlobalButton(
                  title: ("Login"),
                  onTap: () {
                    if(emailController.isNotEmpty&&passwordController.isNotEmpty) {
                      context.read<AuthenticationCubit>().loginUser(
                      gmail: emailController,
                      password: passwordController,
                    );
                    }
                  }),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Already new member?",style: TextStyle(
                      color: AppColors.c_3669C9,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.registerScreen);
                    },
                    child: Text(
                      "Register",
                      style:  TextStyle(
                          color: AppColors.c_3669C9,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],)
            ],
          );
        },
    buildWhen: (previous,current){
    print("PREVIOUS:$previous AND CURRENT:$current");
    return previous!=current;},
        listener: (context, state) {

          if (state is AuthLoggedState) {
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );

  }
}
