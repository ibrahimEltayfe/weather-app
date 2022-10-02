import 'dart:developer';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_projects/app_routers.dart';
import 'package:my_projects/constants/app_routes.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/theme_manager/theme_manager_bloc.dart';
import 'package:my_projects/services/bloc_observer.dart';
import 'package:my_projects/services/connectivity_service.dart';
import 'package:my_projects/services/injector.dart' as d;
import 'package:my_projects/services/shared_pref.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await ConnectivityService().initialize();
  d.init();
  await SharedPrefHelper.init();
  Bloc.observer = SimpleBlocObserver();

  bool isDark = SharedPrefHelper.getThemeMode();

  runApp(
      DevicePreview(
        enabled: false,
        builder:(c)=> MyApp(isDark: isDark,),
      )
  );

}

class MyApp extends StatelessWidget {
  bool isDark;
  MyApp({required this.isDark,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevicePreview.appBuilder(
      context, ScreenUtilInit(
          useInheritedMediaQuery: true,

          designSize: const Size(360, 690),
          minTextAdapt: true,
          builder: (c,w) => BlocProvider(
            create: (context) => ThemeManagerBloc(isDark),
            child: BlocBuilder<ThemeManagerBloc,ThemeManagerState>(
              builder: (context, state) {
               return MaterialApp(
                  theme: state.themeData,
                  useInheritedMediaQuery: true,
                  debugShowCheckedModeBanner: false,
                  locale: DevicePreview.locale(context),
                  onGenerateRoute:RoutesManager.routes,
                  initialRoute:AppRoutes.homePage,
                );
              },

            ),
          )
      ),
    );

  }
}




