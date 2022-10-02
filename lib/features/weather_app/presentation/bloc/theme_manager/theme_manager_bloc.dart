import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_projects/constants/app_themes.dart';
import 'package:my_projects/services/shared_pref.dart';

part 'theme_manager_event.dart';
part 'theme_manager_state.dart';

class ThemeManagerBloc extends Bloc<ThemeManagerEvent, ThemeManagerState> {
  bool isDark;
  ThemeManagerBloc(this.isDark) : super(ThemeManagerState(isDark?darkTheme():lightTheme())) {

    on<ThemeChanged>((event, emit) async{
      isDark = !isDark;

      if(isDark){
        emit(ThemeManagerState(darkTheme()));
      }else{
        emit(ThemeManagerState(lightTheme()));
      }

      try{
        await SharedPrefHelper.saveThemeMode(isDark: isDark);
      }catch(e){
        Fluttertoast.showToast(msg: 'failed to save theme mode');
      }


    });
  }
}
