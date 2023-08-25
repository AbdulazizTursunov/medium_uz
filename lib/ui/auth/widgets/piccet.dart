import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors/app_colors.dart';


class CaptionText extends StatelessWidget {
  const CaptionText({Key? key, required this.title}) : super(key: key);
final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.labelLarge!.copyWith(
        fontSize: 15.sp, color: AppColors.black, fontWeight: FontWeight.w500
    ));
  }
}
