import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_projects/error/network_checker.dart';
import 'package:my_projects/features/weather_app/data/data_sources/weather_api.dart';
import 'package:my_projects/features/weather_app/data/repositories/weather_repository_impl.dart';
import 'package:my_projects/features/weather_app/domain/repositories/weather_repository.dart';
import 'package:my_projects/features/weather_app/domain/use_cases/air_pollution_forecast_usecase.dart';
import 'package:my_projects/features/weather_app/domain/use_cases/current_air_pollution_usecase.dart';
import 'package:my_projects/features/weather_app/domain/use_cases/current_weather_usecase.dart';
import 'package:my_projects/features/weather_app/domain/use_cases/fiveday_forecast_usecase.dart';
import 'package:my_projects/features/weather_app/domain/use_cases/historical_air_pollution_usecase.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/current_weather_cubit/current_weather_cubit.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/weather_forecast_cubit/weather_forecast_cubit.dart';

final injector = GetIt.instance;

void init(){
//! core
 //!errors
  //network_info
  injector.registerLazySingleton<NetworkInfo>(() => NetworkInfo(injector()));
  injector.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

//! features
 //! weather
  //blocs
  injector.registerFactory<CurrentWeatherCubit>(() => CurrentWeatherCubit(injector(),injector()));
  injector.registerFactory<WeatherForecastCubit>(() => WeatherForecastCubit(injector(),injector()));

  //data sources
  injector.registerLazySingleton<WeatherAPI>(() => WeatherAPI());
  //repositories
  injector.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(injector(),injector()));
  injector.registerLazySingleton<WeatherRepositoryImpl>(() => WeatherRepositoryImpl(injector(),injector()));
  //use cases
   injector.registerLazySingleton<CurrentWeatherUseCase>(() => CurrentWeatherUseCase(injector()));
  injector.registerLazySingleton<FiveDayForecastUseCase>(() => FiveDayForecastUseCase(injector()));
  injector.registerLazySingleton<AirPollutionForecastUseCase>(() => AirPollutionForecastUseCase(injector()));
  injector.registerLazySingleton<CurrentAirPollutionUseCase>(() => CurrentAirPollutionUseCase(injector()));
  injector.registerLazySingleton<HistoricalAirPollutionUseCase>(() => HistoricalAirPollutionUseCase(injector()));
}