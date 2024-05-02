import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

abstract class AppTextStyle{

  static TextStyle font24BlackTextStyle(){
    return GoogleFonts.oxygen(
      textStyle: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
  static TextStyle font45OrangeTextStyle(){
    return GoogleFonts.oxygen(
      textStyle: const TextStyle(
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }
  static TextStyle font18GeryTextStyle(){
    return GoogleFonts.oxygen(
      textStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade900,
      ),
    );
  }
  static TextStyle font18OrangeTextStyle(){
    return GoogleFonts.oxygen(
      textStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }
  static TextStyle font18WhiteTextStyle(){
    return GoogleFonts.oxygen(
      textStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
  static TextStyle font25WhiteTextStyle(){
    return GoogleFonts.oxygen(
      textStyle: const TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
  static TextStyle font32BlackTextStyle(){
    return GoogleFonts.oxygen(
      textStyle: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  static TextStyle font20BlueGreyTextStyle(){
    return GoogleFonts.oxygen(
      textStyle:  TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        color: Colors.blueGrey.shade800,

      ),
    );
  }

}