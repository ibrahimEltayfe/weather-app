import 'package:flutter/material.dart';
import 'package:my_projects/constants/app_colors.dart';

TextStyle _getTextStyle(double fontSize, Color color,String fontFamily,TextDecoration? textDecoration,FontWeight? fontWeight){
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    color: color,
    decoration: textDecoration,
    fontWeight: fontWeight
  );
}

TextStyle getRegularTextStyle({
         double fontSize = 15.5,
         Color color = AppColors.blackBlue,
         String fontFamily = 'sen',
         TextDecoration? textDecoration,
         FontWeight? fontWeight
}) {
  return _getTextStyle(fontSize,color,fontFamily,textDecoration,fontWeight);
}

TextStyle getBoldTextStyle({
  double fontSize = 23,
  Color color = AppColors.blackBlue,
  String fontFamily = 'sen',
  TextDecoration? textDecoration,
  FontWeight? fontWeight = FontWeight.w700
}) {
  return _getTextStyle(fontSize,color,fontFamily,textDecoration,fontWeight);
}

TextStyle getAppNameStyle(){
  return TextStyle(
      fontFamily: 'panton',
      fontSize: 38,
      color: Colors.black,
  );
}



