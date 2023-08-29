import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medium_uz/cubit/auth/auth_cubit.dart';
import 'package:medium_uz/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:medium_uz/data/models/user_model/user_model_enum_filds.dart';
import 'package:medium_uz/ui/auth/pages/widget/gender_selector.dart';
import 'package:medium_uz/ui/auth/pages/widget/gender_selector_radio_button.dart';
import 'package:medium_uz/ui/auth/widgets/piccet.dart';
import 'package:medium_uz/utils/images/app_images.dart';
import '../../../cubit/auth/abstract_auth_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../routes/app_routes.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ImagePicker picker = ImagePicker();
  String phone='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("register screen"),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthState>(
          builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 20),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: const CaptionText(title: "Name"),
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
                hintText: "Name",
                prefixIconIn: Icons.person,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  context.read<UserDataCubit>().updateCurrentUserField(
                      userModelFieldKeys: UserModelFieldKeys.username,
                      value: value);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: const CaptionText(title: "Phone"),
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
                hintText: "+998 _ _  _ _ _  _ _  _ _",
                keyboardType: TextInputType.phone,
                // maskTextInputFormatter: maskFormatter,
                prefixIconIn: Icons.phone,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  String phone = value.replaceAll(" ", "");
                  phone = phone.replaceAll("(", "");
                  phone = phone.replaceAll(")", "");
                  phone = phone.replaceAll("-", "");
                  debugPrint("444444444444444444444444444444444444444444444444444$phone");
                  context.read<UserDataCubit>().updateCurrentUserField(
                      userModelFieldKeys: UserModelFieldKeys.contact,
                      value: phone);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: const CaptionText(title: "E-mail"),
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
                hintText: "Email",
                prefixIconIn: Icons.email,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  context.read<UserDataCubit>().updateCurrentUserField(
                      userModelFieldKeys: UserModelFieldKeys.email,
                      value: value);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: const CaptionText(title: "Password"),
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
                hintText: "Password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  context.read<UserDataCubit>().updateCurrentUserField(
                      userModelFieldKeys: UserModelFieldKeys.password,
                      value: value);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.r),
              child: const CaptionText(title: "Profession"),
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
                hintText: "Profession",
                prefixIconIn: Icons.work,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  context.read<UserDataCubit>().updateCurrentUserField(
                      userModelFieldKeys: UserModelFieldKeys.profession,
                      value: value);
                }),
            const SizedBox(height: 10),
            const GenderSelector(),
         // const   GenderSelectorRadioButton(),
            if (context.read<UserDataCubit>().state.userModel.avatar.isEmpty)
              // SizedBox(
              //   height: 200,
              //   child: Image.file(File(context.read<UserDataCubit>().state.userModel.avatar),
              // ),),
            const SizedBox(height: 10),
            GlobalButton(title: "Select image", onTap: (){
              showBottomSheetDialog();
            }),

            const SizedBox(height: 20),
            GlobalButton(
                title: "Register",
                onTap: () {
                  if (context.read<UserDataCubit>().canRegister()) {
                    debugPrint("----------------------------------------${context.read<UserDataCubit>().state.userModel.avatar}");
                    debugPrint("----------------------------------------${phone}");
                    context.read<AuthenticationCubit>().sendCodeToGmail(
                      context.read<UserDataCubit>().state.userModel.email,
                      context
                          .read<UserDataCubit>()
                          .state
                          .userModel
                          .password,
                    );
                  }else{
                    showErrorMessage(message: "registratsiya oyna maydonlari to'liq emas", context: context);
                  }
                  // context.read<UserDataCubit>().clearData();
                }),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Already a member?",
                  style: TextStyle(
                      color: AppColors.c_3669C9,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteNames.signIn);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: AppColors.c_3669C9,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            )
          ],
        );
      },
          buildWhen: (previous,current){
            print("PREVIOUS:$previous AND CURRENT:$current");
            return previous!=current;},
          listener: (context, state) {
        if (state is AuthSendCodeSuccessState) {

          Navigator.pushNamed(
            context,
            RouteNames.confirmGmailCode,
            arguments: context.read<UserDataCubit>().state.userModel,
          );
        }

        if (state is AuthErrorState) {
          showErrorMessage(message: state.errorText, context: context);
        }
      }
      )
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
          userModelFieldKeys: UserModelFieldKeys.avatar, value: xFile.path);
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
          userModelFieldKeys: UserModelFieldKeys.avatar, value: xFile.path);
    }
  }
}
