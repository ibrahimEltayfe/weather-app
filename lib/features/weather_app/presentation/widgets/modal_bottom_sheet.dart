import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/theme_manager/theme_manager_bloc.dart';

class CustomModalBottomSheet extends StatelessWidget {
  const CustomModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: 0.4.sh,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height:10.h),
                  Container(
                    width: 23.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xFF787878).withOpacity(0.2),
                    ),
                  ),

                  //switch
                  SizedBox(
                    width: 50.w,
                    height: 40.h,
                    child:_buildSwitch(context)
                  ),
                ],
              ),
            )
        );
      },
      child: _bottomSheetShape(Theme.of(context)),
    );
  }

  Widget _bottomSheetShape(ThemeData theme){
    return Container(
      width: double.infinity,
      height: 26.h,
      alignment: Alignment(0,-0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r),),
        color: theme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: Offset(0, 1.h),
            blurRadius: 6.r,
          ),
        ],
      ),
      child: Container(
        width: 23.0,
        height: 3.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: theme.primaryColor.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildSwitch(BuildContext context){
    return Platform.isAndroid
        ?Switch(
        value: context.read<ThemeManagerBloc>().isDark,
        onChanged: (val){
          context.read<ThemeManagerBloc>().add(ThemeChanged());
        }
       )
        :CupertinoSwitch(
        value: context.read<ThemeManagerBloc>().isDark,
        onChanged: (val){
          context.read<ThemeManagerBloc>().add(ThemeChanged());
        }
    );
  }
}
