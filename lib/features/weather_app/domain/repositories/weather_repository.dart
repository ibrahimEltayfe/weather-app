import 'package:dartz/dartz.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/air_pollution_entity.dart';
import 'package:my_projects/features/weather_app/domain/entities/five_day_forecast.dart';
import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';

abstract class WeatherRepository{
 Future<Either<Failure,WeatherEntity>> getCurrentWeather();
 Future<Either<Failure,FiveDayForecastEntity>> getFiveDayForecast();
 Future<Either<Failure,AirPollutionEntity>> getCurrentAirPollution();
 Future<Either<Failure,AirPollutionEntity>> getAirPollutionForecast();
 Future<Either<Failure,AirPollutionEntity>> getHistoricalAirPollution({required String start,required String end});
}