import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/app_routes.dart';
import 'features/weather_app/presentation/bloc/current_weather_cubit/current_weather_cubit.dart';
import 'package:my_projects/services/injector.dart' as d;

import 'features/weather_app/presentation/bloc/weather_forecast_cubit/weather_forecast_cubit.dart';
import 'features/weather_app/presentation/pages/current_weather/current_weather_page.dart';

class RoutesManager{
  static Route<dynamic> routes(RouteSettings settings){
    switch(settings.name){
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
              child: const CurrentWeatherPage()
          ),
          settings: settings
      );

      default: return MaterialPageRoute(
          builder: (_)=> const UnExpectedPage(),
          settings: settings
      );

    }

  }
}

class UnExpectedPage extends StatelessWidget {
  const UnExpectedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox(),
      ),
    );
  }
}
