import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AppTheme{
  static ThemeData light (){
    return ThemeData(
      brightness: Brightness.light,
      primaryColor:AppColors.primary ,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      secondaryHeaderColor: AppColors.backgroundSecondaryLight,

      colorScheme: const ColorScheme.light(
         primary: AppColors.primary,
         secondary: AppColors.secondary, 
         tertiary: AppColors.third
        ),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textLight),
        bodySmall: TextStyle(color: AppColors.textSecondaryLight)
      ) ,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData dark(){
    return ThemeData(
     brightness: Brightness.dark,
     primaryColor: AppColors.primary,
     scaffoldBackgroundColor: AppColors.backgroundDark,
     secondaryHeaderColor: AppColors.backgroundSecondaryDark,
     colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.third,
     ),

    textTheme:  const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textDark),
      bodySmall: TextStyle(color: AppColors.textSecondaryDark),
    ) ,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    cardColor: AppColors.backgroundSecondaryDarkHome,
    dividerColor: Colors.white12,
    canvasColor: AppColors.backgroundDarkHome,
    );
  }
}

class AppFonts{
  static String heading(){
    return Get.locale?.languageCode =='ar' ? 
    
    'Tajawal' : 'Raleway' ;
  }

 static String  body (){
  return Get.locale?.languageCode == 'ar' ? 
  
  'Cairo' : 'NunitoSans';
 }

}