import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../utils/colors/app_colors.dart';

class GlobalTextField extends StatefulWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.textAlign,
    this.prefixIconIn,
    this.obscureText = false,
    this.maxLine = 1,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  IconData? prefixIconIn;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  TextAlign textAlign;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final int maxLine;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool isSee = false;

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '+998 (##) ### - ## - ##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: AppColors.c_3669C9),
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8.r,
              offset: const Offset(7, 5),
            )
          ]
      ),
      child: TextField(
        cursorColor: Color(0xFF4F8962),

        maxLines: widget.maxLine,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.c_0C1A30,
            fontFamily: "DMSans"),
        textAlign: widget.textAlign,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText && isSee,
        onChanged: widget.onChanged,
        inputFormatters: widget.keyboardType == TextInputType.phone ? [maskFormatter]:null,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintText: widget.hintText,
          suffixIcon:widget.obscureText? IconButton(
            splashRadius: 1,
            onPressed: () {
              setState(() {
                isSee = !isSee;
              });
            },
            icon: Icon(isSee
                ? Icons.remove_red_eye
                : CupertinoIcons.eye_slash_fill),
            color: AppColors.c_838589,
          )
              : Icon(
          widget.prefixIconIn,
          color: AppColors.c_838589,
        ),

            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.c_0C1A30,
              fontFamily: "DMSans"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: AppColors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
