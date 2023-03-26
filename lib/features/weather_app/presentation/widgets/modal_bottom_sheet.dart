import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              height: MediaQuery.of(context).size.height*0.4,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height:10),
                  Container(
                    width: 23.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xFF787878).withOpacity(0.2),
                    ),
                  ),

                  SizedBox(height:20),
                  Text("Change Theme",style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 22),),

                  _BuildThemeSwitcher()

                ],
              ),
            )
        );
      },
      child: const _BottomSheetShape(),
    );
  }

}

class _BottomSheetShape extends StatelessWidget {
  const _BottomSheetShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 34,
      alignment: Alignment(0,-0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25),),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: Container(
        width: 23.0,
        height: 3.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Theme.of(context).primaryColor.withOpacity(0.6),
        ),
      ),
    );
  }
}

class _BuildThemeSwitcher extends StatelessWidget {
  const _BuildThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 45,
      child: Platform.isAndroid
          ? Switch(
          value: context
              .read<ThemeManagerBloc>()
              .isDark,
          onChanged: (val) {
            context.read<ThemeManagerBloc>().add(ThemeChanged());
          }
      )
          : CupertinoSwitch(
          value: context
              .read<ThemeManagerBloc>()
              .isDark,
          onChanged: (val) {
            context.read<ThemeManagerBloc>().add(ThemeChanged());
          }
      ),
    );
  }
}


