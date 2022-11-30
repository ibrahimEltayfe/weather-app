import 'package:flutter/material.dart';
import 'package:my_projects/constants/app_colors.dart';
import 'package:my_projects/constants/app_styles.dart';

ThemeData lightTheme(){
  return ThemeData(
    primaryIconTheme:IconThemeData(color: AppColors.blackBlue) ,
    brightness: Brightness.light,
    fontFamily: 'sen',
    primaryColor: AppColors.blackBlue,
    backgroundColor: AppColors.bgColor,
    iconTheme: IconThemeData(color: AppColors.blackBlue,size: 19),
    textTheme: TextTheme(
      headline1: getBoldTextStyle(color: AppColors.blackBlue),
      headline2: getRegularTextStyle(color: AppColors.blackBlue)
    ),
    bottomSheetTheme:const BottomSheetThemeData(
      backgroundColor: AppColors.bgColor,
      modalBackgroundColor: AppColors.bgColor,
    ),
    buttonTheme:const ButtonThemeData(
      buttonColor: AppColors.bgColor,
    ),
    scaffoldBackgroundColor: AppColors.bgColor,

  );
}

ThemeData darkTheme(){
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'sen',
    primaryColor: AppColors.dAthensGray,
    backgroundColor: AppColors.dBgColor,
    iconTheme: IconThemeData(color: AppColors.dAthensGray),
    textTheme: TextTheme(
        headline1: getBoldTextStyle(color: AppColors.dAthensGray),
        headline2: getRegularTextStyle(color: AppColors.dAthensGray)
    ),
    bottomSheetTheme:const BottomSheetThemeData(
      backgroundColor: AppColors.dBgColor,
      modalBackgroundColor: AppColors.dBgColor,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.dBgColor,
    ),
    scaffoldBackgroundColor: AppColors.dBgColor,
  );
}