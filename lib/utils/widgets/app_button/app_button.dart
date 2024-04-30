import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';
import '../../text_styles/text_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback fn;
  final String text;
  const AppButton({super.key ,required this.fn,required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        width: double.infinity,
        height: 55.0,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.secondColor,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.font18WhiteTextStyle(),
          ),
        ),
      ),
    );
  }
}
