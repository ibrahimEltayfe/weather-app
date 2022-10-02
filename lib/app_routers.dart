import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_projects/error/network_checker.dart';
import 'package:my_projects/features/google_search_app/presentation/bloc/search_cubit.dart';
import 'package:my_projects/features/google_search_app/presentation/pages/google_search/google_search_api.dart';
import 'package:my_projects/features/home/presentation/pages/no_internet_page.dart';
import 'package:my_projects/features/map/presentation/pages/map_page.dart';
import 'package:my_projects/reusable_components/custom_page_route.dart';
import 'constants/app_routes.dart';
import 'features/dice_app/presentation/pages/dice.dart';
import 'features/google_search_app/data/repository/repository.dart';
import 'features/home/presentation/pages/home.dart';
import 'features/weather_app/presentation/bloc/current_weather_cubit/current_weather_cubit.dart';
import 'package:my_projects/services/injector.dart' as d;

import 'features/weather_app/presentation/bloc/weather_forecast_cubit/weather_forecast_cubit.dart';
import 'features/weather_app/presentation/pages/current_weather/current_weather_page.dart';

class RoutesManager{
  static Route<dynamic> routes(RouteSettings settings){
    switch(settings.name){

      case AppRoutes.homePage: return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Home(),
        settings: settings,
        opaque: false
      );

      case AppRoutes.googleSearchPage: return MaterialPageRoute(
          builder: (_)=> BlocProvider(
              create: (context) => SearchCubit(SearchRepository(NetworkInfo(InternetConnectionChecker()))),
              child: GoogleSearchPage()
          ),
          settings: settings,
      );

      case AppRoutes.dicePage: return CustomPageRoute(
            child: const Dice(),
            routeSettings: settings
        );

      case AppRoutes.weatherPage: return PageRouteBuilder(
          pageBuilder: (c,a,_)=> MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                   d.injector<CurrentWeatherCubit>()..getCurrentWeather(),
                ),
                BlocProvider(
                  create: (context) =>
                   d.injector<WeatherForecastCubit>()..getForecastWeather(),
                ),
              ],
              child: CurrentWeatherPage()
          ),
          settings: settings
      );

      case AppRoutes.mapPage: return MaterialPageRoute(
          builder: (_)=> MapPage(),
          settings: settings
      );

      case AppRoutes.noInternetPage: return MaterialPageRoute(
          builder: (_)=> NoInternetPage(),
          settings: settings
      );

      default: return MaterialPageRoute(
          builder: (_)=> Home(),
          settings: settings
      );

    }

  }
}