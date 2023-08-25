import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubit/auth/auth_cubit.dart';
import 'package:medium_uz/cubit/user_data_cubit/user_data_cubit.dart';
import '../../../cubit/auth/abstract_auth_state.dart';
import '../../../data/models/user_model/user_model.dart';
import '../../../data/models/user_model/user_model_enum_filds.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../routes/app_routes.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_fields.dart';

class CodeInput extends StatefulWidget {
  CodeInput({super.key, required this.userModel});

  UserModel userModel;

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  String? codeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gmail Confirm Screen"),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalTextField(
                hintText: "Code",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (value){
                  codeController = value;
                }
              ),
              SizedBox(height: 30.h),
              GlobalButton(
                title: "Confirm",

                onTap: () {
                  debugPrint(" = ======================================================${codeController}");
                  if (codeController!=null) context.read<AuthenticationCubit>().confirmGmail(codeController!);
                },
              ),
              const SizedBox(height: 50)
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthConfirmCodeSuccessState) {
            context.read<AuthenticationCubit>().registerUser(widget.userModel);
          }
          if (state is AuthLoggedState) {
            context.read<UserDataCubit>().clearData();

            Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabBox,(route) => false);
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
        buildWhen: (previous,current){
          print("PREVIOUS:$previous AND CURRENT:$current");
          return previous!=current;},
      ),
    );
  }
}
