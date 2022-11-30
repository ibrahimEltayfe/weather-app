import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_projects/app_routers.dart';
import 'package:my_projects/constants/app_routes.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/theme_manager/theme_manager_bloc.dart';
import 'package:my_projects/services/bloc_observer.dart';
import 'package:my_projects/services/injector.dart' as d;
import 'package:my_projects/services/shared_pref.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';


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
      context, BlocProvider(
            create: (context) => ThemeManagerBloc(isDark),
            child: BlocBuilder<ThemeManagerBloc,ThemeManagerState>(
              builder: (context, state) {
               return MaterialApp(
                  theme: state.themeData,
                  useInheritedMediaQuery: true,
                  debugShowCheckedModeBanner: false,
                  locale: DevicePreview.locale(context),
                 builder: (context, child) {
                   return ResponsiveWrapper.builder(
                     BouncingScrollWrapper.builder(context, child!),

                     defaultScale: true,
                     breakpoints: [
                       const ResponsiveBreakpoint.resize(450, name: MOBILE),
                       const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                       const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                       const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                       const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                     ],
                   );
                 },
                  onGenerateRoute:RoutesManager.routes,
                  initialRoute:AppRoutes.homePage,
                );
              },

            ),
          )
      ,
    );

  }
}




